'use client'
import { useState } from 'react';
import ReportMonth from '../component/reportMonth/report'
import ReportDay from '../component/reportDay/report'


export default function Home() {
  const [optionsChart, setOptionsChart] = useState("");

  return (
    <div className="main-header card">
      <div className="container-fluid">
        <div className="row mb-2">
          <div className="col-sm-6">
            <h1>Thống kê doanh thu</h1>
          </div>
          <div className="col-sm-6">
            <ol className="breadcrumb float-sm-right">
              <div className="card-tools flex items-center" style={{ alignItems: "center" }}>
                <h5>Thống kê theo : </h5>
                <select
                  value={optionsChart}
                  onChange={(e) => {
                    setOptionsChart(e.target.value);
                  }}
                >
                  <option value="month">Tháng</option>
                  <option value="year">Năm</option>
                </select>


              </div>
            </ol>
          </div>
        </div>
      </div>
      {optionsChart == 'month' ? (<ReportDay />) : <ReportMonth />}



    </div>
  )
}

