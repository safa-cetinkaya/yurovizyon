import {
    Controller, Get, Header, Post, Query, Req, StreamableFile, UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '../auth/auth.guard';
import { AuthService } from '../auth/auth.service';
import { LevelGuard } from 'src/auth/level.guard';
import { READ_ONLY_LEVEL, UPLOAD_PATH_PROFILE } from 'src/common/utils';
import * as sharp from 'sharp';
import { UserService } from './user.service';

@Controller('user')
@UseGuards(AuthGuard)
export class UserController {
    constructor(
        private readonly userService: UserService,
        private readonly sessionService: AuthService,
    ) { }

    @Get('information')
    async getInformation(@Req() req: Request) {
        return req.body!['session']['user'];
    }

    @Get('get_users')
    async getUsers() {
        return await this.userService.findBy({});
    }

    @Get('get_sessions')
    async getSessions(@Req() req: Request) {
        return await this.sessionService.findBy({ user_fk: req.body!['session']['user_fk'] });
    }

    @Post('edit_profile')
    async editProfile(@Req() req: Request) {
        const q = req.body!;
        var user = q['session']['user'];

        if (q['username'] != null) user.username = q['username'];
        if (q['name'] != null) user.name = q['name'];
        if (q['surname'] != null) user.surname = q['surname'];
        if (q['bio'] != null) user.bio = q['bio'];

        if (q['profile_image'] != null) user.profile_image = q['profile_image'];
        if (q['deleted'] == 1) user.profile_image = null;

        if (q['ranking'] != null) user.ranking = q['ranking'];

        return await this.userService.saveUser(user);
    }

    @Get('profile_picture')
    @Header('Content-Type', 'image/png')
    @UseGuards(LevelGuard(READ_ONLY_LEVEL))
    async getProfileImage(@Req() req: Request, @Query() q) {
        const profile_image = q['profile_image'] ?? req.body!['session']['user']['profile_image'];

        const imagePath = `${UPLOAD_PATH_PROFILE}${profile_image}.jpg`;
        const readStream = sharp(imagePath);

        q['size'] ??= 200;
        if (!isNaN(+q['size']))
            readStream.resize({
                width: +q['size'],
                height: +q['size'],
                fit: 'inside',
            });

        return new StreamableFile(readStream);
    }
}