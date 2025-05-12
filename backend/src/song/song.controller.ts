import {
    Controller, Get, Header, HttpException, HttpStatus, Post, Query, Req, StreamableFile, UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '../auth/auth.guard';
import { SongService } from './song.service';
import { Song } from './song.entity';
import { UPLOAD_PATH_GENERAL } from 'src/common/utils';
import * as sharp from 'sharp';

@Controller('song')
@UseGuards(AuthGuard)
export class SongController {
    constructor(
        private readonly songService: SongService,
    ) { }

    @Get('get_one')
    async getSong(@Req() _: Request, @Query() q) {
        return await this.songService.findOneBySongPK(q['song_pk']);
    }

    @Get('get_all')
    async getSongs(@Req() _: Request) {
        return await this.songService.findBy({});
    }

    @Post('save')
    async saveSong(@Req() req: Request) {
        const q = req.body!;

        var song = {
            name: q['name'],
            artist: q['artist'],
            country: q['country'],
            image_path: q['image_path'],
            length: +q['length'],
        } as Song;

        return await this.songService.saveSong(song);
    }

    @Get('get_image')
    @Header('Content-Type', 'image/png')
    async getSongImage(@Req() req: Request, @Query() q) {
        if (q['song_pk'] == null)
            throw new HttpException('no_info', HttpStatus.BAD_REQUEST);

        const song = await this.songService.findOneBySongPK(q['song_pk']);;

        const imagePath = `${UPLOAD_PATH_GENERAL}${song?.image_path}.jpg`;
        const readStream = sharp(imagePath);
        return new StreamableFile(readStream);
    }
}
