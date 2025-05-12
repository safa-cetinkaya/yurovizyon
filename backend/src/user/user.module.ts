import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './user.entity';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { AuthModule } from 'src/auth/auth.module';


@Module({
    imports: [
        TypeOrmModule.forFeature([User]),
        forwardRef(() => AuthModule),
    ],
    providers: [UserService],
    exports: [UserService],
    controllers: [UserController],
})
export class UserModule { }
