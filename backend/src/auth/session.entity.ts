import {
    Entity,
    Column,
    PrimaryGeneratedColumn,
    JoinColumn,
    ManyToOne,
} from 'typeorm';
import { BaseEntity, relOpt } from '../common/base.entity';
import { User } from '../user/user.entity';

@Entity()
export class Session extends BaseEntity {
    @PrimaryGeneratedColumn('uuid')
    session_pk: string;

    @ManyToOne(() => User, (user) => user.sessions, relOpt)
    @JoinColumn([{ name: 'user_fk', referencedColumnName: 'user_pk' }])
    user: User;

    @Column()
    user_fk: string;

    @Column('jsonb', { nullable: true })
    vars: object;
}
