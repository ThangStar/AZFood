'use client'

import { formatDate } from "@/component/utils/formatDate";
import formatMoney from "@/component/utils/formatMoney";
import { useAppDispatch, useAppSelector } from "@/redux-store/hooks";
import { getDetailsInvoiceAsync, getInvoiceDetaiil, getInvoiceList, getInvoiceListAsync } from "@/redux-store/invoice-reducer/invoiceSlice";
import Link from "next/link";
import { useEffect, useState } from "react";


const ListInvoice = () => {

    const dispatch = useAppDispatch();
    const invoiceList: any = useAppSelector(getInvoiceList);
    const invoiceDetails: any = useAppSelector(getInvoiceDetaiil);

    const [invoiceStateList, setInvoiceStateList] = useState<any[]>([]);
    const [invoiceDetailsStateList, setInvoiceDetailsStateList] = useState<any[]>([]);

    const [showDetails, setShowDetails] = useState(false);
    const [invoiceID, setInvoiceID] = useState<number | null>(null);
    const [invoiceNumber, setInvoiceNumber] = useState<number | null>(null);
    const [selectedInvoice, setSelectedInvoice] = useState<number | null>(null);

    useEffect(() => {
        const fetchData = async () => {
            await dispatch(getInvoiceListAsync());
        };

        fetchData();
    }, []);
    useEffect(() => {
        if (invoiceID !== null) {
            dispatch(getDetailsInvoiceAsync(invoiceID));
        }
    }, [invoiceID]);
    useEffect(() => {
        if (invoiceList && invoiceList.resultRaw) {
            setInvoiceStateList(invoiceList.resultRaw);
        }
        if (invoiceDetails && invoiceDetails.resultRaw) {
            setInvoiceDetailsStateList(invoiceDetails.resultRaw);
        }
    }, [invoiceList, invoiceDetails]);

    const active = () => {
        return `background-color: #f5f5f5`;
    }
    return (
        <div className="main-header card">
            <div className="card-header">
                <div className="container-fluid">
                    <div className="row mb-2">
                        <div className="col-sm-6">
                            <h1>Danh sách Hóa đơn</h1>
                        </div>
                        <div className="col-sm-6">
                            <ol className="breadcrumb float-sm-right">
                                <li className="breadcrumb-item"><a href="#">Trang chủ</a></li>
                                <li className="breadcrumb-item active">Hoá đơn</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <div className="container-fluid">
                <div className="row">
                    <div className="col-12">
                        <div className="card">
                            <div className="card-header">
                                <h3 className="card-title">Danh sách hóa đơn</h3>
                            </div>
                            <div className="invoice-content row d-flex" style={{ marginTop: 20 }}>
                                <div className="table-responsive" style={{ width: showDetails ? "65%" : "100%" }}>
                                    <table id="example2" className="table table-bordered table-hover" >
                                        <thead>
                                            <tr>
                                                <th style={{ width: "5%" }}>Số hóa đơn</th>
                                                <th >Bàn</th>
                                                <th>Ngày thanh toán </th>
                                                <th>Tên nhân viên</th>
                                                <th>Tổng tiền</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            {invoiceStateList.map((invoice: any, i: number) => (
                                                <tr key={invoice.id} onClick={() => {
                                                    setShowDetails(true);
                                                    setInvoiceID(invoice.id);
                                                    setInvoiceNumber(invoice.invoiceNumber)
                                                }} >
                                                    <td>
                                                        <Link href={`invoice/invoice-details?id=${invoice && invoice.id ? invoice.id : null}`}>{invoice.invoiceNumber}</Link>
                                                    </td>
                                                    <td>{invoice.table_Name}</td>
                                                    <td>{formatDate(invoice.createAt)}</td>
                                                    <td>{invoice.userName}</td>
                                                    <td>{formatMoney(invoice.total)} VND

                                                    </td>

                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                </div>
                                {showDetails == true ? <>
                                    <div className="form-horizontal" style={{
                                        width: "33%", maxHeight: 600, overflowY: "auto", padding: 10, borderWidth: 1,
                                        borderColor: "red", borderRadius: 20
                                    }}>
                                        <div className="row align-items-center">
                                            <div className="col-md-6">
                                                <h4>Ch tiết hóa đơn</h4>
                                            </div>

                                            <button className="btn btn-danger" style={{ width: "20%", marginRight: 0 }} onClick={() => {
                                                setShowDetails(false);
                                            }}>X</button>
                                        </div>

                                        {invoiceDetailsStateList && invoiceDetailsStateList.length > 0 ? (
                                            <div>
                                                <div className="title">
                                                    <p>Số hóa đơn : {invoiceNumber}</p>
                                                </div>
                                                <div style={{ width: "100%" }}>
                                                    <table id="example2" className="table table-bordered table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>Tên món </th>
                                                                <th>Số lượng</th>
                                                                <th>Tổng tiền</th>
                                                            </tr>
                                                        </thead>

                                                        <tbody>
                                                            {invoiceDetailsStateList.map((item, id) => (
                                                                <tr >
                                                                    <td>{item.poductName}</td>
                                                                    <td>{item.quantity}</td>
                                                                    <td>{formatMoney(item.totalAmount)} VND</td>
                                                                </tr>
                                                            ))}
                                                        </tbody>
                                                    </table>
                                                </div>

                                            </div>
                                        ) : null}

                                    </div>
                                </> : " "}
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    )
}
export default ListInvoice;