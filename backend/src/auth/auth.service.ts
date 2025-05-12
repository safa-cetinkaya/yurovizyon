import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { InjectRepository } from '@nestjs/typeorm';
import { FindOptionsWhere, Repository } from 'typeorm';
import { SALT_LENGTH } from 'src/common/utils';
import { Session } from './session.entity';
import { User } from 'src/user/user.entity';
import { UserService } from 'src/user/user.service';

@Injectable()
export class AuthService {
    constructor(
        @InjectRepository(Session)
        private sessionRepository: Repository<Session>,
        private readonly userService: UserService,
    ) { }

    findAll(): Promise<Session[] | null> {
        const findManyOptions = { relations: { user: true } };
        return this.sessionRepository.find(findManyOptions);
    }

    async findOneBySessionID(session_pk: string): Promise<Session | null> {
        const findManyOptions = {
            where: { session_pk: session_pk },
            relations: { user: true },
        };

        var session: any = (await this.sessionRepository.findOne(findManyOptions))!;
        delete session.user.password;

        return session;
    }

    async deleteAllSessions(user: User) {
        await this.sessionRepository.delete({ user_fk: user.user_pk });
    }

    findBy(where: FindOptionsWhere<Session>): Promise<Session[] | null> {
        where.state = 1;
        return this.sessionRepository.find({ where: where });
    }

    async update(session: Session) {
        session.time_updated = new Date();
        await this.sessionRepository.save(session);
    }

    async save(user: User): Promise<Session> {
        let session = new Session();
        session.user = user;

        if (!session.vars) {
            session.vars = {};
        }

        session = await this.sessionRepository.save(session);
        return session;
    }

    async remove(session_pk: string): Promise<any> {
        return await this.sessionRepository.delete({ session_pk: session_pk });
    }

    async deactivateSession(Session: Session): Promise<void> {
        Session.state = -1;
        await this.sessionRepository.save(Session);
    }

    async login(username: string, password: string) {
        const user = await this.userService.findForLogin(username);

        if (!user) throw new HttpException('no_user', HttpStatus.BAD_REQUEST);
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) throw new HttpException('no_match', HttpStatus.BAD_REQUEST);

        const session = await this.save(user);
        return session;
    }

    async register(user: User) {
        user.password = await bcrypt.hash(user.password, SALT_LENGTH);

        var result: any = await this.userService.saveUser(user);
        delete result.password;

        return result;
    }

    async changePassword(user: User, oldPassword: string, newPassword: string) {
        user = (await this.userService.findOneByUserPK(user.user_pk, true))!;

        const isMatch = await bcrypt.compare(oldPassword, user.password);
        if (!isMatch) throw new HttpException('wrong_pass', HttpStatus.BAD_REQUEST);

        user.password = await bcrypt.hash(newPassword, SALT_LENGTH);
        user = await this.userService.saveUser(user);
    }

    async forgotPassword(user: User, newPassword: string) {
        user = (await this.userService.findOneByUserPK(user.user_pk))!;
        user.password = await bcrypt.hash(newPassword, SALT_LENGTH);

        await this.userService.saveUser(user);
    }
}
