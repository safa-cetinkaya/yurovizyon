import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Session } from './session.entity';
import { UserModule } from '../user/user.module';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';

@Module({
    imports: [
        TypeOrmModule.forFeature([Session]),
        forwardRef(() => UserModule),
    ],
    providers: [AuthService],
    exports: [AuthService],
    controllers: [AuthController],
})
export class AuthModule { }
