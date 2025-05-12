const UPLOAD_PATH = `${process.cwd()}/../_uploads`;
export const UPLOAD_PATH_PROFILE = `${UPLOAD_PATH}/profile/`;
export const UPLOAD_PATH_GENERAL = `${UPLOAD_PATH}/general/`;

export const MIN_IMAGE_SIZE = 300;
export const MAX_IMAGE_SIZE = 1920;

export const READ_ONLY_LEVEL = 10;
export const MOD_LEVEL = 100;
export const ADMIN_LEVEL = 1000;
export const SUPER_ADMIN_LEVEL = 10000;
export const SALT_LENGTH = 10;

export function Tr2En(text: string) {
    const maps = {
        "İ": "I", "Ş": "S", "Ç": "C", "Ğ": "G", "Ü": "U", "Ö": "O",
        "ı": "i", "ş": "s", "ç": "c", "ğ": "g", "ü": "u", "ö": "o"
    };
    Object.keys(maps).forEach(function (old) {
        text = text.replace(old, maps[old]);
    });
    return text;
}

export function createStrictObject<T extends object>(obj: T, template: T): T {
    return Object.keys(obj).reduce((acc, key) => {
        if (key in template) {
            (acc as any)[key] = (obj as any)[key];
        }
        return acc;
    }, {} as T);
}