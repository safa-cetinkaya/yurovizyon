import { Module } from '@nestjs/common';
import { TypeOrmModule, TypeOrmModuleOptions } from '@nestjs/typeorm';
import { dbConfig } from './app.config';
import { User } from './user/user.entity';
import { Session } from './auth/session.entity';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { Song } from './song/song.entity';
import { SongModule } from './song/song.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      ...(dbConfig as TypeOrmModuleOptions),
      entities: [
        User,
        Session,
        Song,
      ],
    }),
    UserModule,
    AuthModule,
    SongModule
  ],
  controllers: [],
  providers: [],
})
export class AppModule { }
