import { format } from 'date-fns-tz';

const formatDateTime = (date: string) => {
    return formatDateWithPattern(date, 'HH:mm:ss');
};

const formatDate = (date: string) => {
    return formatDateWithPattern(date, 'dd/MM/yyyy');
};

const formatDateWithPattern = (date: string, pattern: string) => {
    const vietnamTimeZone = 'Asia/Ho_Chi_Minh';

    try {
        const formattedDate = format(new Date(date), pattern, { timeZone: vietnamTimeZone });
        return formattedDate;
    } catch (error) {
        console.error('Error formatting date:', error);
        return '';
    }
};

export { formatDateTime, formatDate };