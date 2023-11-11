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
        <>
            <div className="container-fluid">
                <div className="p-3" style={{ borderBottom: '1.5px solid rgb(195 211 210)'}}>
                    <h3 className='m-0' style={{ height: '40px' }}>Danh sách hóa đơn</h3>
                </div>
            </div>


            <div className="container-fluid">
                <div className="row">
                    <div className="col-12">
                        <div className="">
                            <div className="invoice-content row d-flex" style={{ marginTop: 20 }}>
                                <div className="table-responsive" style={{ width: showDetails ? "65%" : "100%" }}>
                                    <table id="example2" className="table table-bordered table-hover" >
                                        <thead>
                                            <tr>
                                                <th style={{ width: "8%" }}>SHĐ</th>
                                                <th>Bàn</th>
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
                                        <div style={{ display: 'flex', justifyContent: 'space-between', borderBottom: '1.5px solid rgb(195 211 210)', padding: '8px 0' }}>
                                            <h6 style={{ margin: '0' }}>Chi tiết hóa đơn</h6>

                                            <button style={{ backgroundColor: 'red', color: 'white', padding: '5px 8px', borderRadius: '5px' }} onClick={() => {
                                                setShowDetails(false);
                                            }}>
                                                <h6 style={{ margin: '0' }}>
                                                    Đóng
                                                </h6>
                                            </button>
                                        </div>

                                        {invoiceDetailsStateList && invoiceDetailsStateList.length > 0 ? (
                                            <div className="mt-2">
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
                            onClick={() => handlePageChange(currentPage + 1)}>
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

        </>

    )
}
export default ListInvoice;