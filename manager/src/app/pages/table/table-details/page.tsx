'use client'
import { AppDispatch } from '@/redux-store/store';
import { getTableList, getTableListAsync } from '@/redux-store/table-reducer/tableSlice';
import Link from 'next/link';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';

export default function TableDetails() {
  const dispatch: AppDispatch = useDispatch();
  const tableList: any = useSelector(getTableList);
  const [tables, setTables] = useState<any[]>([]);


  useEffect(() => {

    dispatch(getTableListAsync());

  }, [dispatch]);

  useEffect(() => {
    if (tableList && tableList.resultRaw) {
      setTables(tableList.resultRaw);
    }
  }, [tableList]);
  const ban = "#DC3545";
  const trong = "#26A744";
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
                                <small>from</small>
                                <div className="m-t-5 m-b-5">
                                    Takatech Company<br />
                                    Address: 200 Hà Huy Tập - P.Tân Lợi - TP.BMT<br />
                                    Phone: (123) 456-7890<br />
                                    Fax: (123) 456-7890
                                </div>
                            </div>
                            <div className="invoice-to">
                                <small>to</small>
                                <div className="m-t-5 m-b-5">
                                    Name : 
                                    {/* {billDetails ? billDetails.name : ""} <br />
                                    {billDetails ? `${billDetails.street} - ${billDetails.ward} - ${billDetails.district} - ${billDetails.citys}` : ""}<br />
                                    Phone: {billDetails ? billDetails.phoneNumber : ""}<br /> */}

                                </div>
                            </div>
                            <div className="invoice-date">
                                <small>Bill / Date</small>
                                <div className="date text-inverse m-t-5">
                                  {/* {billDetails ? moment(billDetails.createAt).format() : ""} */}
                                  </div>
                                <div className="invoice-detail">
                                    {/* #{billDetails ? billDetails.orderNumber : ""}<br /> */}
                                    Services Product
                                </div>
                            </div>
                        </div>
                        <div className="invoice-content" style={{ marginTop: 20 }}>
                            <div className="table-responsive">
                                <table className="table table-invoice">
                                    <thead>
                                        <tr>
                                            <th style={{ fontSize: 18, fontWeight: "bold", color: "red" }}>PRODUCT IN THE BILL</th>
                                            <th className="text-center" style={{ width: "20%" }}>CATEGORY</th>
                                            <th className="text-center" style={{ width: "20%" }}>PRICE</th>
                                            <th className="text-center" style={{ width: "10%" }}>QUANTITY</th>
                                            <th className="text-right" style={{ width: "20%" }}>TOTALAMOUNT</th>
                                        </tr>
                                    </thead>
                                    {/* <tbody>
                                        {productList && productList.map((product, index) => (
                                            <tr key={index}>
                                                <td style={{ color: "green", fontSize: 20 }}>
                                                    {product.name}<br />
                                                </td>
                                                <td className="text-center">{product.category}</td>
                                                <td className="text-center">${product.price}</td>
                                                <td className="text-center">{product.quantity}</td>
                                                <td className="text-right">${(product.price * product.quantity)}</td>
                                            </tr>
                                        ))}
                                    </tbody> */}
                                </table>
                            </div>
                        </div>
                        <div className="invoice-price">
                            <div className="invoice-price-left">
                                <div className="invoice-price-row">
                                    <div className="sub-price">
                                        <small>SUBTOTAL</small>
                                        <span className="text-inverse">$ 
                                        {/* {caculatorTotal()} */}
                                        </span>
                                    </div>
                                    <div className="sub-price">
                                        <small>PAYPAL FEE (0%)</small>
                                        <span className="text-inverse">$0</span>
                                    </div>
                                </div>
                            </div>
                            <div className="invoice-price-right">
                                <small>TOTAL</small> <span className="f-w-600">$ 
                                {
                                // caculatorTotal()
                                }</span>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
  )
}
