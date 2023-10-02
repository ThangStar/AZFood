'use client'

import { showAlert } from "@/component/utils/alert/alert";
import { formatDate } from "@/component/utils/formatDate";
import formatMoney from "@/component/utils/formatMoney";
import { useAppDispatch, useAppSelector } from "@/redux-store/hooks";
import { getDetailsInvoiceAsync, getInvoiceDetaiil, getInvoiceList, getInvoiceListAsync, getSearchDateInvoiceListAsync } from "@/redux-store/invoice-reducer/invoiceSlice";
import Link from "next/link";
import { useEffect, useState } from "react";
import { Button, Modal, ModalBody, ModalFooter, ModalHeader } from "reactstrap";


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


    const [currentPage, setCurrentPage] = useState(1);

    const [modal, setModal] = useState(false);
    const [startDate, setStartDate] = useState<string>('');
    const [endDate, setEndDate] = useState<string>('');
    const [contentSeach, setContentSeach] = useState('');

    const toggle = () => setModal(!modal);
    const openModal = (data: any = null) => {
        if (data) {
            setStartDate(data.startDate);
            setEndDate(data.endDate);
        }
        toggle();
    }

    const search = () => {
        if (endDate == '' || startDate == '') {
            showAlert("error", " Không được để trống");
            return
        }
        const start = new Date(startDate);
        const end = new Date(endDate);

        if (start.getTime() > end.getTime()) {
            showAlert("error", " Ngày end nhỏ hơn ngày start");
        } else {
            if (start.getTime() == end.getTime())
                setContentSeach(`Tìm kiếm trong ngày ${startDate}`)
            else
                setContentSeach(`Tìm kiếm từ ngày ${startDate} đến hết ngày ${endDate}`)
            end.setDate(end.getDate() + 1);
            dispatch(getSearchDateInvoiceListAsync({ 'startDate': start, 'endDate': end }));
            toggle()
        }
    }

    const onCancelSearch = () => {
        handlePageChange(currentPage);
        setContentSeach('')
    }


    const totalPages = invoiceList.totalPages || 1;


    useEffect(() => {
        handlePageChange(currentPage);
    }, []);
    const handlePageChange = (page: number) => {
        setCurrentPage(page);
        dispatch(getInvoiceListAsync(page));
    };
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
    console.log("invoiceList ", invoiceList);

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
            <div className="d-flex justify-content-center align-items-center">
                <ul className="pagination">
                    <li className={`page-item ${currentPage === 1 ? 'disabled' : ''}`}>
                        <button
                            className="page-link"
                            onClick={() => handlePageChange(currentPage - 1)}
                        >
                            {"<="}
                        </button>
                    </li>
                    {Array.from({ length: totalPages }, (_, i) => (
                        <li
                            className={`page-item ${currentPage === i + 1 ? 'active' : ''}`}
                            key={i + 1}
                        >
                            <button
                                className="page-link"
                                onClick={() => handlePageChange(i + 1)}
                            >
                                {i + 1}
                            </button>
                        </li>
                    ))}
                    <li className={`page-item ${currentPage === totalPages ? 'disabled' : ''}`}>
                        <button
                            className="page-link"
                            onClick={() => handlePageChange(currentPage + 1)}
                        >
                            {"=>"}
                        </button>
                    </li>
                </ul>
            </div>


            <Modal isOpen={modal} toggle={openModal} backdrop={'static'}>
                <ModalHeader toggle={openModal}>{"Tìm kiếm theo ngày "}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label" htmlFor="start-date">Từ ngày: </label>
                                <div className="col-sm-8">
                                    <input
                                        className="form-control"
                                        id="start-date"
                                        type="date"
                                        value={startDate ? startDate : ''}
                                        onChange={(e) => setStartDate(e.target.value)}
                                    />
                                </div>
                            </div>

                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label" htmlFor="end-date">Đến hết ngày </label>
                                <div className="col-sm-8">
                                    <input
                                        className="form-control"
                                        id="end-date"
                                        type="date"
                                        value={endDate ? endDate : ''}
                                        onChange={(e) => setEndDate(e.target.value)}
                                    />
                                </div>
                            </div>
                        </div>

                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={() => {
                        search();
                    }}>
                        Tìm
                    </Button>
                    <Button color="secondary" onClick={() => openModal()}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>

        </div>

    )
}
export default ListInvoice;