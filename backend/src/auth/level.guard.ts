import {
    CanActivate,
    ExecutionContext,
    HttpException,
    HttpStatus,
    Injectable,
    mixin,
} from '@nestjs/common';
import { AuthGuard } from 'src/auth/auth.guard';
import { AuthService } from 'src/auth/auth.service';

export const LevelGuard = (level: number) => {
    @Injectable()
    class LevelGuardMixin implements CanActivate {
        constructor(readonly authService: AuthService) { }

        canActivate(context: ExecutionContext): boolean | Promise<boolean> {
            const request = context.switchToHttp().getRequest();
            return this.validateRequest(request);
        }

        async validateRequest(request: Request): Promise<boolean> {
            if (request.body == null) {
                throw new HttpException('no_user', HttpStatus.BAD_REQUEST);
            }

            if (request.body['session'] == null)
                await new AuthGuard(this.authService).validateRequest(request);

            if (request.body['session'].user.level < level)
                throw new HttpException('no_permission', HttpStatus.UNAUTHORIZED);

            return true;
        }
    }

    const guard = mixin(LevelGuardMixin);
    return guard;
};
