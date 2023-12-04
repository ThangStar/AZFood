"use client"
import { useEffect, useRef, useState } from "react";
import Chart from 'chart.js/auto';
import { AppDispatch } from "@/redux-store/store";
import { useDispatch, useSelector } from "react-redux";
import { getEvenueMonthList, getEvenueMonthListAsync } from "@/redux-store/evenue-reducer/evenueSlice";
import { Line } from 'react-chartjs-2';

const reportDay = (selectMonth: any) => {
    const dispatch: AppDispatch = useDispatch();
    const evenueList: any = useSelector(getEvenueMonthList);
    const [evenueMonthList, setEevenueMonthList] = useState<any[]>([]);
    const chartRef = useRef<HTMLCanvasElement | null>(null);
    const chartInstanceRef = useRef<Chart | null>(null);
    const [currentMonth, setCurrentMonth] = useState(new Date().getMonth() + 1);
    const month = selectMonth.selectedYear;
    useEffect(() => {
        if (evenueList && evenueList.result) {
            setEevenueMonthList(evenueList.result);
        }

    }, [evenueList]);

    useEffect(() => {
        dispatch(getEvenueMonthListAsync(month));
    }, [dispatch, month]);

    useEffect(() => {
        const canvas = chartRef.current;
        if (canvas) {
            const ctx = canvas.getContext('2d');

            if (ctx) {
                const month = evenueMonthList.map(item => `Ngày ${item.day}`);
                const totalAmount = evenueMonthList.map(item => item.total_amount);

                const data = {
                    labels: month,
                    datasets: [
                        {
                            label: 'Tổng tiền',
                            data: totalAmount,
                            backgroundColor: 'rgba(57, 204, 204, 0.5)',
                            borderColor: 'rgba(57, 204, 204, 1)',
                            borderWidth: 1,
                        },
                    ],
                };
                if (!chartInstanceRef.current) {
                    chartInstanceRef.current = new Chart(ctx, {
                        type: 'line',
                        data: data,
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                y: {
                                    beginAtZero: true,
                                },
                            },
                        },
                    });
                } else {
                    chartInstanceRef.current.data = data;
                    chartInstanceRef.current.options = {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                            },
                        },
                    };

                    chartInstanceRef.current.update();
                }

            }
        }
    }, [evenueMonthList]);
    console.log("selectMonth ", selectMonth);
    console.log("evenueMonthList ", evenueMonthList);


    return (
        <>

            <div className="container">
                <div className="card-header">

                </div>
                <div className="card">
                    <div className="card-header border-0">
                        <h3 className="card-title">
                            Doanh Thu
                        </h3>

                    </div>
                    <div className="card-body">
                        <canvas className="chart" id="line-chart" ref={chartRef} style={{ minHeight: 250, height: 250, maxHeight: 250, maxWidth: '100%' }} />
                    </div>
                    <div className="card-footer bg-transparent" style={{ justifyContent: "center", alignSelf: "center" }}>

                        <h3>Doanh thu trong tháng {month} trong năm 2023 </h3>

                    </div>
                </div>
            </div>
        </>


    )
}
export default reportDay;
