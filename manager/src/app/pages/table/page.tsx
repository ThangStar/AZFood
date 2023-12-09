'use client'
import { getOrderList, getOrderListAsync } from '@/redux-store/order-reducer/orderSlice';
import { AppDispatch } from '@/redux-store/store';
import { createTableListAsync, deleteTableAsync, getStatusTableAsync, getTableList, getTableListAsync, getTableStatusList, updateStatusTableAsync } from '@/redux-store/table-reducer/tableSlice';
import Link from 'next/link';
import { Modal, ModalHeader, ModalBody, ModalFooter, Button } from 'reactstrap';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import formatMoney from '@/component/utils/formatMoney';
import { showAlert } from '@/component/utils/alert/alert';
import { useSocket } from "@/socket/io.init"
import LeftSideBar from '@/component/LeftSideBar/LeftSideBar'

export default function Table() {
    const socket = useSocket();
    const dispatch: AppDispatch = useDispatch();
    const tableList: any = useSelector(getTableList);
    const orderList: any = useSelector(getOrderList);
    const statusList: any = useSelector(getTableStatusList);
    const [tables, setTables] = useState<any[]>([]);
    const [money, setMoney] = useState<any[]>([]);
    const [orders, setOrders] = useState<any[]>([]);
    const [statusTable, setStatusTable] = useState<any[]>([]);
    const [modal, setModal] = useState(false);
    const [modal1, setModal1] = useState(false);
    const [modalDel, setModalDel] = useState(false);
    const [status, setStatus] = useState<number>(0);
    const [tableName, setTableName] = useState("");
    const [statusTableFilter, setStatusTableFilter] = useState("");
    const [id, setID] = useState<number>(0);
    const [filteredTables, setFilteredTables] = useState<any[]>([]);

    useEffect(() => {
        if (socket) {
            console.log('đã kết nối với socket');

            socket.emit('table', statusTable);
            socket.on('response', (data) => {
                console.log('đã nhận dữ liệu socket', data);
                setTables(data);
            })
        }
    }, [socket]);

    useEffect(() => {
        dispatch(getTableListAsync());
        dispatch(getOrderListAsync());
        dispatch(getStatusTableAsync());

    }, [dispatch]);

    // const calculateTotalForTable = (tableID: number) => {
    //     const ordersForTable: any[] = orders.filter((order: any) => order.tableID === tableID);
    //     let totalAmount = ordersForTable.reduce((acc: number, order: any) => {
    //         return acc + order.totalAmount;

    //     }, 0);

    //     if (socket && tables) {
    //         const tableData = tables.find((table: any) => table.id === tableID);
    //         if (tableData && tableData.total_amount !== null) {
    //             totalAmount = tableData.total_amount;
    //         }
    //         if(totalAmount == null){
    //             totalAmount = 0;
    //         }
    //     }

    //     return totalAmount;
    // };


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

    console.log('tableList', tableList);


    useEffect(() => {
        if (statusTableFilter === 'all') {
            setFilteredTables(tables);
        } else {
            const filtered = tables.filter((table) => {
                if (statusTableFilter === 'trong') {
                    return table.status === 3;
                } else if (statusTableFilter === 'ban') {
                    return table.status === 2;
                } else if (statusTableFilter === 'cho') {
                    return table.status === 1;
                } else if (statusTableFilter === 'mangve') {
                    return table.name === 'mang về';
                }

                return true;
            });

            setFilteredTables(filtered);
        }
    }, [statusTableFilter, tables]);
    const toggle = () => setModal(!modal);
    const toggle1 = () => setModal1(!modal1);
    const toggleDel = () => setModalDel(!modalDel);

    const openModal1 = () => {
        toggle1();
    }

    const openModalDel = () => {
        toggleDel()
    }
    const handleChangeDataForm = (e: any) => {
        setStatus(e.target.value);

    }
    const handleChangeDataForm1 = (e: any) => {
        setTableName(e.target.value);

    }

    const handleUpdate = async (id: any) => {
        try {
            await dispatch(updateStatusTableAsync({ id }));
            dispatch(getTableListAsync());
        } catch (error) {
            console.log(" error : ", error);
        }
    }

    const addTable = async () => {
        if (tableName === "") {
            showAlert('error', 'Bạn chưa nhập tên bàn');
            return;
        }
        try {

            await dispatch(createTableListAsync({ name: tableName }));
            dispatch(getTableListAsync());
            showAlert('success', 'Thêm bàn thành công');
            openModal1();
        } catch (error) {
            console.log(" error : ", error);
        }

    }

    const handleDeleteTable = () => {
        dispatch(deleteTableAsync(id)).then((response) => {
            if (response?.meta?.requestStatus === 'fulfilled') {
                dispatch(getTableListAsync())
                openModalDel()
                showAlert('success', 'Xóa bàn thành công')
            } else {
                showAlert('error', 'Có lỗi khi xóa bàn')
            }
        })
    }
    const ban = "#DC3545";
    const trong = "#26A744";
    const cho = "black";
    return (
        <div className="content scroll">
            <div style={{ marginRight: '15px', border: 'none' }}>
                <div className="container-fluid">
                    <div style={{ borderBottom: '1.5px solid rgb(195 211 210)' }} className='p-3'>
                        <div style={{ justifyContent: 'space-between', display: 'flex' }}>
                            <h3 style={{ height: '40px', margin: '0px' }}>Danh sách bàn</h3>
                            <button className="btn btn-success" onClick={() => { openModal1() }}>Thêm bàn mới</button>
                        </div>
                    </div>
                </div>
                <div style={{ display: 'flex', justifyContent: 'end', padding: '20px', alignItems: 'center' }}>
                    <h6 style={{ margin: '0' }}>Bộ lọc:</h6>
                    <div className="card-tools ml-2" style={{ display: 'flex', width: '230px' }}>
                        <select
                            className="form-control"
                            id="statusTable"
                            value={statusTableFilter}
                            onChange={(e) => {
                                setStatusTableFilter(e.target.value);
                            }}>
                            <option value='' disabled selected hidden>Lọc theo trạng thái bàn</option>
                            <option value='all'>Tất cả</option>
                            <option value='trong' style={{ color: trong }}>Bàn đang trống</option>
                            <option value='ban' style={{ color: ban }}>Bàn đã thanh toán</option>
                            <option value='cho' style={{ color: cho }}>Bàn có khách</option>
                        </select>
                    </div>
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gridGap: '10px', padding: '0px 15px' }}>

                    {filteredTables && filteredTables.length > 0 ? filteredTables.map((item: any, i: number) => (
                        <div key={item.id} style={{ position: 'relative' }}>
                            {item.status === 2 ? ( // Kiểm tra trạng thái của bàn
                                <div style={{ padding: '15px', margin: '5px', border: '1.5px solid #F39422', borderRadius: '20px', color: '#F39422' }}>
                                    <div style={{ display: 'flex' }}>
                                        <h5 style={{ marginRight: '5px' }}>{item.name}</h5>
                                        <p>({item.status_name})</p>
                                    </div>
                                    <div style={{ display: 'flex', justifyContent: 'center' }}>
                                        <button onClick={() => { handleUpdate(item.id) }} className='btn btn-warning btn-sm'>
                                            Chuyển về bàn trống
                                        </button>
                                    </div>

                                </div>

                            ) : item.status === 1 ? (
                                <div style={{ padding: '15px', margin: '5px', border: '1.5px solid #26A744', borderRadius: '20px' }}>
                                    <Link href={`table/table-details?tableID=${item.id}`}>
                                        <h5 style={{ height: '40px', color: '#26A744' }}>{item.name}</h5>
                                        <div style={{ display: 'grid' }}>
                                            <span className="badge" style={{ fontSize: '16px', color: '#26A744' }}>
                                                {item.status_name}
                                            </span>
                                        </div>
                                    </Link>
                                </div>
                            ) : (
                                <div style={{ padding: '15px', margin: '5px', border: '1.5px solid #007bff', borderRadius: '20px' }}>
                                    <Link href={`table/table-details?tableID=${item.id}`}>
                                        <h5 style={{ height: '40px' }}>{item.name}</h5>
                                        <div style={{ display: 'grid' }}>
                                            <span className="badge" style={{ fontSize: '16px', color: '#007bff' }}>
                                                {item.status_name}
                                            </span>
                                        </div>
                                    </Link>
                                </div>
                            )}
                            <div style={{ border: 'none', position: 'absolute', right: '15px', top: '15px', zIndex: '1' }}>
                                {item.status === 3 && (
                                    <button className='btn btn-outline-danger' type="button" onClick={() => {
                                        setID(item.id)
                                        openModalDel()
                                    }}>
                                        <i className="fas fa-trash"></i>
                                    </button>
                                )}
                            </div>
                        </div>
                    )) : ""}
                </div>


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

                <Modal isOpen={modalDel} toggle={openModalDel}>
                    <ModalHeader toggle1={openModal1}>{"Xác nhận xóa bàn"}</ModalHeader>
                    <ModalBody>
                        <form className="form-horizontal">
                            <div className="form-group row">
                                <h4>Bạn có chắc chắn muốn xóa bàn này không? </h4>
                                <div>Sau khi xóa, bàn này sẽ bị xóa vĩnh viễn và không thể khôi phục!</div>
                            </div>
                        </form>
                    </ModalBody>
                    <ModalFooter>
                        <Button color="secondary" onClick={() => {
                            openModalDel()
                        }}>
                            Hủy
                        </Button>
                        <Button color="danger" onClick={() => {
                            handleDeleteTable()
                        }}>
                            Đồng ý xóa
                        </Button>
                    </ModalFooter>
                </Modal>
            </div >
        </div >
    )
}
