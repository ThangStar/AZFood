'use client'
import { getOrderList, getOrderListAsync } from '@/redux-store/order-reducer/orderSlice';
import { AppDispatch } from '@/redux-store/store';
import { getStatusTableAsync, getTableList, getTableListAsync, getTableStatusList, updateStatusTableAsync } from '@/redux-store/table-reducer/tableSlice';
import Link from 'next/link';
import { Modal, ModalHeader, ModalBody, ModalFooter, Button } from 'reactstrap';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';

export default function Table() {
    const dispatch: AppDispatch = useDispatch();
    const tableList: any = useSelector(getTableList);
    const orderList: any = useSelector(getOrderList);
    const statusList: any = useSelector(getTableStatusList);
    const [tables, setTables] = useState<any[]>([]);
    const [orders, setOrders] = useState<any[]>([]);
    const [statusTable, setStatusTable] = useState<any[]>([]);
    const [modal, setModal] = useState(false);
    const [status, setStatus] = useState<number>(0);
    const [id, setID] = useState<number>(0);

    useEffect(() => {

        dispatch(getTableListAsync());
        dispatch(getOrderListAsync());
        dispatch(getStatusTableAsync());

    }, [dispatch]);

    useEffect(() => {
        if (tableList && tableList.resultRaw) {
            setTables(tableList.resultRaw);
        }
        if (orderList && orderList.resultRaw) {
            setOrders(orderList.resultRaw);
        }
        if (statusList && statusList.resultRaw) {
            setStatusTable(statusList.resultRaw);
        }
    }, [tableList]);
    const calculateTotalForTable = (tableID: number) => {
        const ordersForTable: any[] = orders.filter((order: any) => order.tableID === tableID);

        const totalAmount = ordersForTable.map((order: any) => order.totalAmount);

        return totalAmount;
    };

    const toggle = () => setModal(!modal);
    const openModal = (data: any = null) => {
        if (data) {
            //   const dataRaw = { ...data }
            setStatus(data.status);
            setID(data.id)
        } else {
            setStatus(0);
        }


        toggle();
    }
    const handleChangeDataForm = (e: any) => {
        setStatus(e.target.value);

    }
    const handleUpdate = async () => {
        try {
            dispatch(updateStatusTableAsync({ status, id }));
            dispatch(getTableListAsync());
            openModal();
        } catch (error) {
            console.log(" error : ", error);

        }

    }

    const busy = "#DC3545";
    const trong = "#26A744";
    const cho = "yellow";
    return (
        <>
            <div className="main-header card" >
               
                    <div className="container-fluid">
                        <div className="row mb-2">
                            <div className="col-sm-6">
                                <h1>Danh sách món</h1>
                            </div>
                            <div className="col-sm-6">
                                <ol className="breadcrumb float-sm-right">
                                    <li className="breadcrumb-item"><a href="#">Home</a></li>
                                    <li className="breadcrumb-item active">Danh sách Bàn</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                    <div className="content">
                        <div className="card">
                            <div className="card-header">
                                <button className="btn btn-success">Thêm bàn</button>

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
                        <div className="container-fluid row wrap" style={{paddingLeft:80 , paddingRight:80}}>
                            {tables && tables.length > 0 ? tables.map((item: any, i: number) => (
                                <div className="col-md-3 col-sm-8 col-12">
                                    <div className="info-box " style={{ backgroundColor: "#C3E4EA" }}>


                                        <div className="info-box-content">
                                            <Link href='table/table-details' className="info-box-text">{item.name}</Link>
                                            <span className="info-box-number">Tổng tiền : {calculateTotalForTable(item.id)} đ</span>

                                            <button onClick={() => { openModal(item) }} className="info-box-text"
                                                style={{ color: item.status === 2 ? busy : item.status === 1 ? cho : trong }}>
                                                {item.status_name}
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            )) : ""}
                        </div>
                    </div>
               

                <Modal isOpen={modal} toggle={openModal}>
                    <ModalHeader toggle={openModal}>{"Thay đổi trạng thái bàn"}</ModalHeader>
                    <ModalBody>
                        <form className="form-horizontal">
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label">Trạng thái</label>
                                <div className="col-sm-8">

                                    <select
                                        className="form-control"
                                        id="department"
                                        value={status}
                                        onChange={(e) => {
                                            handleChangeDataForm(e);
                                        }}
                                    >
                                        {statusTable && statusTable.length > 0 ? statusTable.map((item: any, id: number) => (
                                            <option value={item.id}>{item.name}</option>


                                        )) : ""}
                                    </select>

                                </div>
                            </div>
                        </form>
                    </ModalBody>
                    <ModalFooter>
                        <Button color="primary" onClick={handleUpdate}>
                            Lưu
                        </Button>{" "}
                        <Button color="secondary" onClick={() => openModal()}>
                            Hủy
                        </Button>
                    </ModalFooter>
                </Modal>
            </div >
        </>
    )
}
