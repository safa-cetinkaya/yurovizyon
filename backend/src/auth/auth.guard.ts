import { Injectable, CanActivate, ExecutionContext, HttpStatus, HttpException } from '@nestjs/common';
import { AuthService } from './auth.service';

@Injectable()
export class AuthGuard implements CanActivate {
    constructor(private readonly authService: AuthService) { }

    canActivate(context: ExecutionContext): boolean | Promise<boolean> {
        const request = context.switchToHttp().getRequest();
        return this.validateRequest(request);
    }

    async validateRequest(request): Promise<boolean> {
        let session_id: string;
        if (request.headers['session-id'] != null)
            session_id = request.headers['session-id'];
        else if (request.query['session-id'] != null)
            session_id = request.query['session-id'];
        else
            throw new HttpException('no_session', HttpStatus.UNAUTHORIZED);

        try {
            request.body ??= {};
            request.body['session'] =
                await this.authService.findOneBySessionID(session_id);
        } catch (e) {
            throw new HttpException('no_session ' + e.toString(), HttpStatus.UNAUTHORIZED);
        }

        if (request.body['session'].state == -1) {
            throw new HttpException('no_session', HttpStatus.UNAUTHORIZED);
        }

        this.authService.update(request.body['session']);

        return request.body['session'] != null;
    }
}
