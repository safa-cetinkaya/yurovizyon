import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FindOptionsWhere, In, Not, Repository } from 'typeorm';
import { Song } from './song.entity';

@Injectable()
export class SongService {
    constructor(
        @InjectRepository(Song)
        private songRepository: Repository<Song>,
    ) { }

    findBy(where: FindOptionsWhere<Song>): Promise<Song[] | null> {
        if (where.state == undefined) where.state = 1;
        return this.songRepository.find({ where: where });
    }

    findOneBy(where: FindOptionsWhere<Song>): Promise<Song | null> {
        if (where.state == undefined) where.state = 1;
        return this.songRepository.findOneBy(where);
    }

    async findOneBySongPK(song_pk: string): Promise<Song | null> {
        return this.songRepository.findOne({
            where: { state: Not(-1), song_pk: song_pk },
        });
    }

    saveSong(song: Song): Promise<Song> {
        return this.songRepository.save(song);
    }

    async deactivateSong(id: number): Promise<void> {
        await this.songRepository.update(id, { state: -1 });
    }
}
