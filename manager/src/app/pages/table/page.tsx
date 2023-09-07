'use client'
import { getOrderList, getOrderListAsync } from '@/redux-store/order-reducer/orderSlice';
import { AppDispatch } from '@/redux-store/store';
import { createTableListAsync, getStatusTableAsync, getTableList, getTableListAsync, getTableStatusList, updateStatusTableAsync } from '@/redux-store/table-reducer/tableSlice';
import Link from 'next/link';
import { Modal, ModalHeader, ModalBody, ModalFooter, Button } from 'reactstrap';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import formatMoney from '@/component/utils/formatMoney';

export default function Table() {
    const dispatch: AppDispatch = useDispatch();
    const tableList: any = useSelector(getTableList);
    const orderList: any = useSelector(getOrderList);
    const statusList: any = useSelector(getTableStatusList);
    const [tables, setTables] = useState<any[]>([]);
    const [orders, setOrders] = useState<any[]>([]);
    const [statusTable, setStatusTable] = useState<any[]>([]);
    const [modal, setModal] = useState(false);
    const [modal1, setModal1] = useState(false);
    const [status, setStatus] = useState<number>(0);
    const [tableName, setTableName] = useState("");
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
    }, [tableList, orderList, statusList]);

    const calculateTotalForTable = (tableID: number) => {
        const ordersForTable: any[] = orders.filter((order: any) => order.tableID === tableID);

        const totalAmount = ordersForTable.reduce((acc: number, order: any) => {
            return acc + order.totalAmount;
        }, 0);

        return totalAmount;
    };
    const toggle = () => setModal(!modal);
    const toggle1 = () => setModal1(!modal1);
    const openModal = (data: any = null) => {
        if (data) {
            setStatus(data.status);
            setID(data.id)
        } else {
            setStatus(0);
        }
        toggle();
    }
    const openModal1 = () => {
        toggle1();
    }
    const handleChangeDataForm = (e: any) => {
        setStatus(e.target.value);

    }
    const handleChangeDataForm1 = (e: any) => {
        setTableName(e.target.value);

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
    const addTable = () => {

        try {
            dispatch(createTableListAsync({ name: tableName }));
            dispatch(getTableListAsync());
            openModal1();
        } catch (error) {
            console.log(" error : ", error);
        }

    }
    const busy = "#DC3545";
    const trong = "#26A744";
    const cho = "yellow";
    return (
        <div className="content" >
            <div className="main-header card" >

                <div className="container-fluid">
                    <div className="row mb-2">
                        <div className="col-sm-6">
                            <h1>Danh sách bàn</h1>
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
                            <button className="btn btn-success" onClick={() => { openModal1() }}>Thêm bàn</button>

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
                    <div className="container-fluid row wrap" style={{ paddingLeft: 80, paddingRight: 80 }}>
                        {tables && tables.length > 0 ? tables.map((item: any, i: number) => (
                            <div className="col-md-3 col-sm-8 col-12">
                                <div className="info-box " style={{ backgroundColor: "#C3E4EA" }}>


                                    <div className="info-box-content">

                                        <Link href={`table/table-details?tableID=${item.id}`}>{item.name}</Link>
                                        <span className="info-box-number">Tổng tiền : {formatMoney(calculateTotalForTable(item.id))} đ</span>

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
                        </Button>
                        <Button color="secondary" onClick={() => openModal()}>
                            Hủy
                        </Button>
                    </ModalFooter>
                </Modal>

                <Modal isOpen={modal1} toggle1={openModal1}>
                    <ModalHeader toggle1={openModal1}>{"Thêm bàn mới"}</ModalHeader>
                    <ModalBody>
                        <form className="form-horizontal">
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label">Tên bàn</label>
                                <div className="col-sm-8">

                                    <input
                                        className="form-control"
                                        id="name"
                                        value={tableName}
                                        onChange={(e) => {
                                            handleChangeDataForm1(e);
                                        }}
                                    />


                                </div>
                            </div>
                        </form>
                    </ModalBody>
                    <ModalFooter>
                        <Button color="primary" onClick={addTable}>
                            Lưu
                        </Button>
                        <Button color="secondary" onClick={() => openModal1()}>
                            Hủy
                        </Button>
                    </ModalFooter>
                </Modal>
            </div >
        </div >
    )
}
