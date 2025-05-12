import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { Song } from './song.entity';
import { SongService } from './song.service';
import { SongController } from './song.controller';

@Module({
    imports: [
        TypeOrmModule.forFeature([Song]),
        forwardRef(() => AuthModule),
    ],
    providers: [SongService],
    exports: [SongService],
    controllers: [SongController],
})
export class SongModule { }
