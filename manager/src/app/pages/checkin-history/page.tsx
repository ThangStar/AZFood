"use client"
import moment from "moment";
import { useEffect, useState } from "react";
import { useAppDispatch, useAppSelector } from "@/redux-store/hooks";
import { getCheckinHistoryList, getCheckinHistoryListAsync } from "@/redux-store/checkin-history-redux/checkin-historySlice";

export default function Home() {
    const dispatch = useAppDispatch();
    const checkinHistoryList: any = useAppSelector(getCheckinHistoryList);

    const [formattedData, setFormattedData] = useState<any[]>([]);

    useEffect(() => {
        dispatch(getCheckinHistoryListAsync());
    }, [dispatch]);

    useEffect(() => {
        if (checkinHistoryList && checkinHistoryList.resultRaw) {
            formatData(checkinHistoryList.resultRaw);
        }
    }, [checkinHistoryList]);


    const formatData = (rawData: any[]) => {
        const formattedData: any[] = [];
        const groupedData: { [key: string]: any } = {};

        rawData.forEach((item) => {
            const { name, date, status } = item;
            const formattedDate = moment(date).format('DD/MM');

            if (!groupedData[name]) {
                groupedData[name] = { name, imgUrl: item.imgUrl, totalWorkingDays: 0, dates: {} };
            }

            if (!groupedData[name].dates[formattedDate]) {
                groupedData[name].dates[formattedDate] = {
                    date: formattedDate,
                    status,
                };

                if (status === 'đi làm ') {
                    groupedData[name].totalWorkingDays++;
                }
            }
        });

        for (const [name, data] of Object.entries(groupedData)) {
            formattedData.push({ ...data, id: Math.random().toString() });
        }

        setFormattedData(formattedData);
    };

    const renderTableData = () => {
        return formattedData.map((item, index) => (
            <tr key={index}>
                <td style={{ fontWeight: "700" }}>{item.name}</td>
                {/* <img alt="avt" style={{ width: 60, height: 60, borderRadius: "50%" }} src={item && item.imgUrl ? item.imgUrl : ""} /> */}
                <td style={{ fontWeight: "700" }}> {item.totalWorkingDays}</td>

                {renderRowTable().map((date, idx) => (
                    <td key={idx}>
                        {item.dates[date.date] ? (
                            <span className={item.dates[date.date].status === 'đi làm ' ? 'text-success' : ''}>
                                {item.dates[date.date].status === 'đi làm ' ? 'đi làm' : ''}
                            </span>
                        ) : (
                            <span className="text-danger">X</span>
                        )}
                    </td>
                ))}
            </tr>
        ));
    };

    const renderRowTable = () => {
        const currentMonth = parseInt(moment().format('MM')) - 2;
        const currentYear = parseInt(moment().format('YYYY'));
        const names = ['CN', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
        let date = new Date(currentYear, currentMonth, 1);
        let result = [];
        while (date.getMonth() === currentMonth) {
            result.push({ date: moment(date).format('DD/MM'), day: names[date.getDay()] });
            date.setDate(date.getDate() + 1);
        }
        return result;
    };

    return (
        <div className="content" style={{ height: 'calc(100vh - 60px)', paddingTop: '10px', borderTop: '1.5px solid rgb(195 211 210)' }}>
            <div className="main-header" style={{ marginRight: '15px', border: 'none' }}>

                    <div className="row mb-2" style={{ borderBottom: '1.5px solid rgb(195 211 210)' }}>
                        <div className="col-sm-6">
                            <h1>Lịch sử Checkin</h1>
                        </div>
                    </div>
                    <div className="card container-fluid mt-4" style={{ overflowY: 'auto' }}>
                        <table className="table table-bordered table-striped projects mt-3">
                            <thead>
                                <tr style={{ fontSize: '9px' }}>
                                    <th>Nhân viên</th>
                                    {/* <th>ảnh</th> */}
                                    <th>Tổng ngày công</th>
                                    {renderRowTable().map((e: any, i: number) => (
                                        <th key={i}>
                                            <span>
                                                <strong>{e.day}</strong><br />
                                                {e.date}
                                            </span>
                                        </th>
                                    ))}
                                </tr>
                            </thead>
                            <tbody style={{ fontSize: '9px' }}>
                                {formattedData.length > 0 ? renderTableData() : null}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

    );
}
