'use client'
import { useEffect, useState } from 'react';
import ReportMonth from '../component/reportMonth/report'
import ReportDay from '../component/reportDay/report'


export default function Home() {
  const [optionsChart, setOptionsChart] = useState("");
  const [selectedMonth, setSelectedMonth] = useState("");
  const [currentMonth, setCurrentMonth] = useState<number>()

  useEffect(() => {
    const currentDate = new Date();
    const getCurrentMonth = currentDate.getMonth() + 1;
    setCurrentMonth(getCurrentMonth);
  }, [currentMonth]);
  const month = [
    {
      value: 1, name: 'Tháng 1'
    }, { value: 2, name: 'Tháng 2' }, { value: 3, name: 'Tháng 3' }, { value: 4, name: 'Tháng 4' }, { value: 5, name: 'Tháng 5' }, { value: 6, name: 'Tháng 6' }
    , { value: 7, name: 'Tháng 7' }, { value: 8, name: 'Tháng 8' }, { value: 9, name: 'Tháng 9' }, { value: 10, name: 'Tháng 10' }, { value: 11, name: 'Tháng 11' }, { value: 12, name: 'Tháng 12' }
  ]
  const years = [2021, 2022, 2023];
  return (
    <>
      <div className="row container-fluid mr-3">
        <div style={{ borderBottom: '1.5px solid rgb(195 211 210)'}} className='p-3'>
          <h3 style={{ height: '40px', margin: '0px' }}>Thống kê doanh thu</h3>
        </div>
        <div>
          <ol className="breadcrumb float-sm-right" style={{ backgroundColor: 'white' }}>
            <div className="card-tools flex items-center" style={{ alignItems: "center" }}>
              <select
                style={{ fontSize: '17px', fontWeight: '500', border: 'none' }}
                value={optionsChart}
                onChange={(e) => {
                  setOptionsChart(e.target.value);
                }}
              >
                <option >Thống kê theo</option>
                <option value="all" selected>Tổng quát</option>
                <option value="month">Tháng</option>
              </select>

            </div>
            <div className="card-tools flex items-center" style={{ alignItems: "center" }}>

              {optionsChart === 'month' ? (
                <div>
                  <select value={selectedMonth} onChange={(e) => setSelectedMonth(e.target.value)}>
                    <option value="">Chọn tháng</option>
                    {month.map((item) => (
                      <option key={item.value} value={item.value}>
                        {item.name}
                      </option>
                    ))}
                  </select>

                </div>
              ) : ""}
            </div>
          </ol>
        </div>
      </div>
      {optionsChart === 'month' ? <ReportDay selectedYear={selectedMonth as string} /> : <ReportMonth />}
    </>
  )
}

