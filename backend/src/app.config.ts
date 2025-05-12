export const dbConfig = {
    type: 'postgres',
    host: 'localhost',
    port: 5432,
    username: 'postgres',
    password: 'postgres',
    database: 'yurovizyondb',
    synchronize: true,
    migrations: ['/migrations/**/*{.ts,.js}'],
    migrationsRun: true
};
