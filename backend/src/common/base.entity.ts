import {
    Column,
    UpdateDateColumn,
    CreateDateColumn,
    RelationOptions,
} from 'typeorm';

export const relOpt: RelationOptions = { createForeignKeyConstraints: false };
export abstract class BaseEntity {
    @Column({ default: 1 })
    state: number;

    @CreateDateColumn({ type: 'timestamptz', default: () => 'CURRENT_TIMESTAMP' })
    time_created: Date;

    @UpdateDateColumn({ type: 'timestamptz', default: () => 'CURRENT_TIMESTAMP' })
    time_updated: Date;
}
