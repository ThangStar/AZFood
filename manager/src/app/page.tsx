'use client'
import { useEffect, useState } from 'react';
import ReportMonth from '../component/reportMonth/report'
import ReportDay from '../component/reportDay/report'
import { useAppDispatch } from '@/redux-store/hooks';
import { useSelector } from 'react-redux';
import { getReportDayList, getReportDayListAsync, getTopMenuList, getTopMenuListAsync } from '@/redux-store/topProduct-reducer/topProductSlice';
import formatMoney from '@/component/utils/formatMoney';
import ReportUser from '@/component/reportUser/report';
import ReportProduct from '@/component/reportProduct/report';

export default function Home() {
  const dispatch = useAppDispatch()
  const topMenuList: any = useSelector(getTopMenuList)
  const reportDayList: any = useSelector(getReportDayList)

  const [type, setType] = useState<'money' | 'menu' | 'user'>('money')
  const [optionsChart, setOptionsChart] = useState("");
  const [selectedMonth, setSelectedMonth] = useState("");
  const [currentMonth, setCurrentMonth] = useState<number>()
  const [reportDays, setReportDays] = useState([]);
  const [selectedDate, setSelectedDate] = useState('');

  useEffect(() => {
    dispatch(getTopMenuListAsync())

    const today = new Date();
    const year = today.getFullYear();
    const month = (today.getMonth() + 1).toString().padStart(2, '0');
    const day = today.getDate().toString().padStart(2, '0');
    const formattedDate = `${year}-${month}-${day}`;
    setSelectedDate(formattedDate);
    dispatch(getReportDayListAsync({ day: day, month: month }))
  }, [])

  useEffect(() => {
    const currentDate = new Date();
    const getCurrentMonth = currentDate.getMonth() + 1;
    setCurrentMonth(getCurrentMonth);
  }, [currentMonth]);

  useEffect(() => {
    if (reportDayList && reportDayList.resultRaw) {
      setReportDays(reportDayList.resultRaw)
    }
  }, [dispatch, reportDayList])

  const month = [
    {
      value: 1, name: 'Tháng 1'
    }, { value: 2, name: 'Tháng 2' }, { value: 3, name: 'Tháng 3' }, { value: 4, name: 'Tháng 4' }, { value: 5, name: 'Tháng 5' }, { value: 6, name: 'Tháng 6' }
    , { value: 7, name: 'Tháng 7' }, { value: 8, name: 'Tháng 8' }, { value: 9, name: 'Tháng 9' }, { value: 10, name: 'Tháng 10' }, { value: 11, name: 'Tháng 11' }, { value: 12, name: 'Tháng 12' }
  ]
  const years = [2021, 2022, 2023];

  const handleReportDay = () => {
    const [year, month, day] = selectedDate.split('-')
    dispatch(getReportDayListAsync({ day: day, month: month }))
  }
  return (
    <>
      <div>
        <ul className="nav nav-tabs">
          <li className="nav-item">
            <button className={`nav-link fs-3 p-3 ${type == 'money' ? 'active fw-medium ' : 'fw-lighter'}`}
              onClick={() => { setType('money') }}>
              Doanh số
            </button>
          </li>
          <li className="nav-item">
            <button className={`nav-link fs-3 p-3 ${type == 'menu' ? 'active fw-medium ' : 'fw-lighter'}`}
              onClick={() => { setType('menu') }}>
              Sản phẩm</button>
          </li>
          <li className="nav-item">
            <button className={`nav-link fs-3 p-3 ${type == 'user' ? 'active fw-medium ' : 'fw-lighter'}`}
              onClick={() => { setType('user') }}>
              Trong ngày</button>
          </li>
        </ul>
      </div>

      {
        type == 'money' &&
        <>
          <div className="row container-fluid">
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
      }

      {
        type == 'menu' &&
        <>
          <div className='container mt-3'>
            <div style={{ fontSize: 24, fontWeight: 'bold', marginLeft: '1%', color: 'ActiveBorder' }}>
              Top 10 Sản phẩm bán chạy nhất
            </div>
            <div className="card card-body border-0 p-0 mx-3 mt-3">
              <table className="table table-striped projects">
                <thead >
                  <tr >
                    <th style={{ width: "5vh" }}>
                      MSP
                    </th>
                    <th>
                      Tên Món
                    </th>
                    <th>
                      Giá
                    </th>
                    <th>
                      Đơn vị Tính
                    </th>
                    <th>
                      Loại món
                    </th>
                    <th>
                      Số lượng bán
                    </th>
                  </tr>
                </thead>
                <tbody>
                  {topMenuList && topMenuList.length > 0 ? topMenuList.map((item: any) => (
                    <tr key={item && item.id ? item.id : null}>
                      <td style={{ textAlign: 'center' }}>
                        {item.id}
                      </td>
                      <td>
                        <div className='d-flex align-items-center'>
                          {item && item.imgUrl ?
                            <img alt="món ăn" style={{ height: 40, width: 40, objectFit: 'cover' }} src={item.imgUrl} />
                            :
                            <img src="" alt=" món ăn" style={{ height: 40 }} />
                          }
                          <div style={{ marginLeft: '10px' }}>
                            {item && item.name ? item.name : null}
                          </div>
                        </div>
                      </td>
                      <td className="project_progress" style={{}}>
                        {item && item.price ? `${formatMoney(item.price)} ₫` : null}
                      </td>
                      <td className="project_progress">
                        {item && item.dvt_name ? item.dvt_name : null}
                      </td>
                      <td className="project_progress">
                        {item && item.category_name ? item.category_name : ""}
                      </td>
                      <td className="project_progress fw-medium">
                        {item && item.totalQuantity ? item.totalQuantity : ""}
                      </td>
                    </tr>
                  )) : ""}
                </tbody>
              </table>
            </div>
          </div>
        </>
      }

      {
        type == 'user' &&
        <>
          <div className="container overflow-hidden mt-2">
            <div className="card-header border-0">
              <div className="float-right">
                <div className="input-group">
                  <input className="form-control" type="date"
                    value={selectedDate}
                    onChange={(e) => setSelectedDate(e.target.value)} />
                  <button className="btn btn-primary"
                    onClick={handleReportDay}>
                    Xác nhận
                  </button>
                </div>
              </div>
            </div>
            {reportDays && reportDays.length > 0 ?
              <div className="row g-3">
                <div className="col-sm-6">
                  <ReportUser originalList={reportDays} />
                </div>
                <div className="col-sm-6">
                  <ReportProduct originalList={reportDays} />
                </div>
              </div>
              : "Không có dữ liệu"}
          </div>
        </>
      }
    </>
  )
}

