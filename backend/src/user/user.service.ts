import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FindOptionsWhere, In, Not, Repository } from 'typeorm';
import { User } from './user.entity';

@Injectable()
export class UserService {
    constructor(
        @InjectRepository(User)
        private userRepository: Repository<User>,
    ) { }

    findBy(where: FindOptionsWhere<User>): Promise<User[] | null> {
        if (where.state == undefined) where.state = 1;
        return this.userRepository.find({ where: where });
    }

    findOneBy(where: FindOptionsWhere<User>): Promise<User | null> {
        if (where.state == undefined) where.state = 1;
        return this.userRepository.findOneBy(where);
    }

    async findOneByUserPK(user_pk: string, get_pass: boolean = false): Promise<User | null> {
        if (get_pass) {
            return (await this.userRepository
                .createQueryBuilder()
                .select('*')
                .where({ state: Not(-1), user_pk: user_pk })
                .getRawOne()) ?? null;
        }

        return this.userRepository.findOne({
            where: { state: Not(-1), user_pk: user_pk },
        });
    }

    async findForLogin(username: string) {
        return this.userRepository
            .createQueryBuilder('u')
            .addSelect('u.password')
            .where({ username: username, state: 1 })
            .getOne();
    }

    saveUser(user: User): Promise<User> {
        return this.userRepository.save(user);
    }

    async deactivateUser(id: number): Promise<void> {
        await this.userRepository.update(id, { state: -1 });
    }
}
