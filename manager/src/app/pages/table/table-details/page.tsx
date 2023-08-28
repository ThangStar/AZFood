'use client'
import { getOrder, getOrderInTableListAsync } from '@/redux-store/order-reducer/orderSlice';
import { AppDispatch } from '@/redux-store/store';
import { getTableList, getTableListAsync } from '@/redux-store/table-reducer/tableSlice';
import Link from 'next/link';
import { useSearchParams } from 'next/navigation';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';

export default function TableDetails() {

    const searchParams = useSearchParams()
    const url = `${searchParams}`
    const tableID = url ? url.split('tableID=')[1] : null;
    

  const dispatch: AppDispatch = useDispatch();
  const orders: any = useSelector(getOrder);
  const [order, setOrder] = useState<any[]>([]);


  useEffect(() => {
    dispatch(getOrderInTableListAsync(tableID));
  }, [dispatch]);

useEffect(() => {
    if (orders && Array.isArray(orders.orders)) { 
      setOrder(orders.orders);
    }
  }, [orders]);

  const caculatorTotal = () => {
    let totalAll = 0;
    order.forEach(item => {
        totalAll += item.price * item.quantity
    });
    return totalAll;
}
  return (
    <div className="wrapper">
            <div className="content-wrapper">
                <div className="container-fluid">
                    <div className="row dl-flex">

                        <div className="invoice-company text-inverse f-w-600">
                            <h2 className="title" style={{ fontSize: 20, fontWeight: "bold", color: "red" }}>Bill Details</h2>
                            <br />
                        </div>
                        <div className="col-md-10 flex justify-content-between" >
                            <div className="invoice-from">
                               
                                <div className="m-t-5 m-b-5">
                                   <h3>Thiên Thai Quán</h3> <br />
                                    Địa chỉ: 200 Hà Huy Tập - P.Tân Lợi - TP.BMT<br />
                                    SĐT: (123) 456-7890<br />
                                    STK: 236-090-151 VpBank Hoang Quoc Huy<br />
                                    
                                </div>
                            </div>
                           
                            <div className="invoice-date">
                                <small>Bill / Date</small>
                                <div className="date text-inverse m-t-5"> 
                                  {order && order.length > 0  ? order[0].orderDate : ""}
                                  </div>
                                <div className="invoice-detail">
                                Tên nhân viên : {order && order.length > 0  ? order[0].userName : ""}
                                </div>
                            </div>
                        </div>
                        <div className="card">
                        <div className="card-header">
                            <button className="btn btn-success">Thêm món</button>

                            <div className="card-tools">
                                <button type="button" className="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                    <i className="fas fa-minus"></i>
                                </button>
                                <button type="button" className="btn btn-tool" data-card-widget="remove" title="Remove">
                                    <i className="fas fa-times"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                        <div className="invoice-content" style={{ marginTop: 20 }}>
                            <div className="table-responsive">
                                <table className="table table-invoice">
                                    <thead>
                                        <tr>
                                            <th style={{ fontSize: 18, fontWeight: "bold", color: "red" }}>Sản phẩm</th>
                                            <th className="text-center" style={{ width: "20%" }}>Giá</th>
                                            <th className="text-center" style={{ width: "20%" }}>Đơn vị tính</th>
                                            <th className="text-center" style={{ width: "10%" }}>Số luọng</th>
                                            <th className="text-right" style={{ width: "20%" }}>Tổng cộng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {order && order.map((item, index) => (
                                            <tr key={index}>
                                                <td style={{ color: "green", fontSize: 20 }}>
                                                    {item.productName}<br />
                                                </td>
                                                <td className="text-center">{item.price}</td>
                                                <td className="text-center">{item.dvt}</td>
                                                <td className="text-center">{item.quantity}</td>
                                                <td className="text-right">{(item.price * item.quantity)}</td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div className="invoice-price">
                            <div className="invoice-price-left">
                                <div className="invoice-price-row">
                                    <div className="sub-price">
                                        <small>Tông tiền : </small>
                                        <span className="text-inverse">  
                                        {caculatorTotal()}
                                        </span>
                                    </div>
                                    
                                </div>
                            </div>
                           
                        </div>
                    </div>

                </div>
            </div>
        </div>
  )
}
