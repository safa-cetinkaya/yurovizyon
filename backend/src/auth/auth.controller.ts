import { Controller, Get, HttpException, HttpStatus, Post, Req, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthGuard } from './auth.guard';
import { User } from '../user/user.entity';

@Controller('auth')
export class AuthController {
    constructor(
        private readonly authService: AuthService,
    ) { }

    @Get('check_session')
    @UseGuards(AuthGuard)
    async checksession(@Req() req: Request) {
        return req.body!['session'];
    }

    @Post('change_password')
    @UseGuards(AuthGuard)
    async changePassword(@Req() req: Request) {
        const q = req.body!;

        await this.authService.changePassword(
            q['session']['user'],
            q['old_password'],
            q['new_password'],
        );

        return true;
    }

    @Post('logout')
    @UseGuards(AuthGuard)
    async logout(@Req() req: Request) {
        this.authService.deactivateSession(req.body!['session']);

        return true;
    }

    @Post('login')
    async login(@Req() req: Request) {
        const q = req.body!;

        if (q['username'] == null || q['password'] == null)
            throw new HttpException('invalid_credentials', HttpStatus.BAD_REQUEST);

        return await this.authService.login(q['username'], q['password']);
    }

    @Post('register')
    async register(@Req() req: Request) {
        const q = req.body!;

        if (q['username'] == null || q['password'] == null)
            throw new HttpException('no_information', HttpStatus.BAD_REQUEST);

        var user = new User();
        user.username = q['username'];
        user.password = q['password'];
        user.level = 10;

        user = await this.authService.register(user);
        return await this.authService.login(q['username'], q['password']);
    }
}
