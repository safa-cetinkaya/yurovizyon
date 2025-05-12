import { Entity, Column, OneToMany, PrimaryGeneratedColumn, ManyToMany, JoinTable } from 'typeorm';
import { BaseEntity, relOpt } from 'src/common/base.entity';
import { Session } from '../auth/session.entity';

@Entity()
export class User extends BaseEntity {
    @PrimaryGeneratedColumn('uuid')
    user_pk: string;

    @Column({ unique: true })
    username: string;

    @Column({ nullable: true })
    name: string;

    @Column({ nullable: true })
    surname: string;

    @Column({ nullable: true })
    bio: string;

    @Column({ type: 'text', select: false })
    password: string;

    @Column({ nullable: true })
    profile_image: string;

    @Column({ default: 1 })
    level: number;

    @OneToMany(() => Session, (session) => session.user, relOpt)
    sessions: Session[];

    @Column('jsonb', { nullable: true })
    ranking: object;
}
