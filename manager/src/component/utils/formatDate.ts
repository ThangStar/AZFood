import { format } from 'date-fns-tz';

const formatDateTime = (date: string) => {
    return formatDateWithPattern(date, 'HH:mm:ss');
};

const formatDate = (date: string) => {
    return formatDateWithPattern(date, 'dd/MM/yyyy');
};

const formatDateWithPattern = (dateString: string, pattern: string) => {
    const vietnamTimeZone = 'Asia/Ho_Chi_Minh';

    try {
        const date = new Date(dateString);
        // Trừ đi 7 giờ từ đối tượng Date
        date.setHours(date.getHours() - 7);
        // Định dạng ngày và giờ với múi giờ Việt Nam
        const formattedDate = format(date, pattern, { timeZone: vietnamTimeZone });
        return formattedDate;
    } catch (error) {
        console.error('Error formatting date:', error);
        return '';
    }
};

const convertUTCToDDMMYYYYHHmm = (utcDatetime: string) => {
    const utcDate = new Date(utcDatetime);

    const day = utcDate.getUTCDate().toString().padStart(2, '0');
    const month = (utcDate.getUTCMonth() + 1).toString().padStart(2, '0');
    const year = utcDate.getUTCFullYear();
    const hours = utcDate.getUTCHours().toString().padStart(2, '0');
    const minutes = utcDate.getUTCMinutes().toString().padStart(2, '0');

    return `${day}/${month}/${year} vào lúc ${hours}:${minutes}`;
}

export { formatDateTime, formatDate, convertUTCToDDMMYYYYHHmm };