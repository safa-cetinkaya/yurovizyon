import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';
import { BaseEntity } from 'src/common/base.entity';

@Entity()
export class Song extends BaseEntity {
    @PrimaryGeneratedColumn('uuid')
    song_pk: string;

    @Column({ unique: true })
    name: string;

    @Column()
    artist: string;

    @Column()
    country: string;

    @Column()
    image_path: string;

    @Column()
    length: number;
}
