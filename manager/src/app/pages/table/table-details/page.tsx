'use client'
import { showAlert } from '@/component/utils/alert/alert';
import { formatDateTime } from '@/component/utils/formatDate';
import formatMoney from '@/component/utils/formatMoney';
import { getUserID } from '@/redux-store/login-reducer/loginSlice';
import { getCategoryList, getCategoryListAsync, getItemtList, getMenuItemListAsync, getMenuItemtList, getMenuListAsync } from '@/redux-store/menuItem-reducer/menuItemSlice';
import { createOrderAsync, deleteOrderAsync, getOrder, getOrderInTableListAsync, getStatus, payBillAsync, updateOrderAsync } from '@/redux-store/order-reducer/orderSlice';
import { AppDispatch } from '@/redux-store/store';
import { getTableList, getTableListAsync } from '@/redux-store/table-reducer/tableSlice';
import { log } from 'console';
import Link from 'next/link';
import { useSearchParams } from 'next/navigation';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Modal, ModalHeader, ModalBody, ModalFooter, Button } from 'reactstrap';
import { useSocket } from "@/socket/io.init"

export default function TableDetails() {
    const socket = useSocket();
    const searchParams = useSearchParams()
    const url = `${searchParams}`
    const tableID = url ? url.split('tableID=')[1] : null;
    const [modal1, setModal1] = useState(false);
    const [modal, setModal] = useState(false);
    const [modal2, setModal2] = useState(false);
    const [isUpdate, setIsUpdate] = useState(false);

    const dispatch: AppDispatch = useDispatch();
    const orders: any = useSelector(getOrder);
    const menuItems: any = useSelector(getItemtList);
    const statusRD: any = useSelector(getStatus);

    const categoryList: any = useSelector(getCategoryList);

    const [order, setOrder] = useState<any[]>([]);
    const [itemMenus, setItemMenus] = useState<any[]>([]);
    const [itemCategory, setItemCategory] = useState("");
    const [isDialogOpen, setIsDialogOpen] = useState(false);
    const [listCategory, setListCategory] = useState<string[]>([]);

    const [quantityOrder, setQuantityOrder] = useState();
    const [productID, setProducID] = useState();
    const [userID, setUserID] = useState();
    const [orderID, setOrderID] = useState();
    const [idItemDelete, setIdDelete] = useState();
    const [nameUpdate, setNameUpdate] = useState("");
    const [itemOrder, setItemOrder] = useState<any>([]);

    const toggle1 = () => setModal1(!modal1);
    const openModal1 = (data: any = null) => {
        console.log(setProducID(data.id));
        console.log(setQuantityOrder(data.quantity));
        if (data != null && data.orderID) {
            setNameUpdate(data.productName);
            setOrderID(data.orderID);
            setProducID(data.productID);
            setQuantityOrder(data.quantity);
        }
        toggle1();
    }
    const toggle = () => setModal(!modal);
    const openModal = (data: any = null) => {

        if (data != null) {
            setIdDelete(data);
        }
        toggle();
    }
    const toggle2 = () => setModal2(!modal2);
    const openModal2 = () => {

        toggle2();
    }
    useEffect(() => {
        const userJSON = localStorage.getItem("user");

        if (userJSON) {
            const user = JSON.parse(userJSON);
            const userID = user.userID;
            setUserID(userID);
        } else {
            console.log("Dữ liệu user không tồn tại trong localStorage");
        }
    }, [userID]);

    const category = parseInt(itemCategory);
    const filteredItems = itemMenus.filter((item) => {

        if (category !== null) {
            return item.category === category;;
        } else {
            return
        }

    });

    useEffect(() => {
        dispatch(getOrderInTableListAsync(tableID));
        dispatch(getMenuListAsync());

    }, [dispatch]);

    useEffect(() => {
        if (orders && Array.isArray(orders.orders)) {
            setOrder(orders.orders);
        }
        if (menuItems && menuItems.data) {
            setItemMenus(menuItems.data);
        }
        if (categoryList && categoryList.resultRaw) {
            setListCategory(categoryList.resultRaw);
        }
    }, [orders, menuItems, categoryList]);

    const handleOpenChoose = () => {
        setIsDialogOpen(true);
        dispatch(getCategoryListAsync());
    }
    const caculatorTotal = () => {
        let totalAll = 0;
        order.forEach(item => {
            totalAll += item.price * item.quantity
        });
        return totalAll;
    }
    const handleOrder = async () => {

        const data = {
            userID: userID,
            tableID: tableID,
            productID: productID,
            quantity: quantityOrder
        }

        console.log('data', data);

        if (isUpdate) {
            await dispatch(updateOrderAsync({ data, orderID }));
            if (statusRD == 'idle') {
                toggle1();
            }
        } else {
            await dispatch(createOrderAsync(data));
            if (statusRD == 'idle') {
                toggle1();
            }
        }
        dispatch(getOrderInTableListAsync(tableID));

    }
    const deleteItem = async (id: any) => {
        await dispatch(deleteOrderAsync(id));
        if (statusRD === 'idle') {
            showAlert("success", "Đã xóa món khỏi order");
            dispatch(getOrderInTableListAsync(tableID));
            toggle();
        }

    }

    const handleThanhToan = () => {
        dispatch(payBillAsync(tableID));
        showAlert("success", "Thanh toán thành công");
        dispatch(getOrderInTableListAsync(tableID));
        toggle2();
    }
    return (
        <div className="content" style={{ height: 'calc(100vh - 60px)', paddingTop: '10px', borderTop: '1.5px solid rgb(195 211 210)' }}>
            <div className="main-header" style={{ marginRight: '15px', border: 'none' }}>
                <div className='header'>
                    <h1>AZFOOD</h1>
                    <div className="col-md-10 flex justify-content-between mt-2 mb-4" >
                        <div className="invoice-from">
                            <small>Bill / Form</small>
                            <div className=" m-b-5">
                                <span style={{ fontWeight: "bold" }}>Địa chỉ: </span> 200 Hà Huy Tập - P.Tân Lợi - TP.BMT<br />
                                <span style={{ fontWeight: "bold" }}>SĐT: </span> (123) 456-7890<br />
                                <span style={{ fontWeight: "bold" }}>STK: </span> 236-090-151 VpBank Hoang Quoc Huy<br />
                            </div>
                        </div>

                        <div className="invoice-date">
                            <small>Bill / Date</small>
                            <div className="date text-inverse m-t-5">
                                <span style={{ fontWeight: "bold" }}>Giờ Vào : </span>{order && order.length > 0 ? `${formatDateTime(order[0].orderDate)}` : ""}
                            </div>
                            <div className="invoice-detail">
                                <span style={{ fontWeight: "bold" }}>Tên nhân viên : </span> {order && order.length > 0 ? order[0].userName : ""}
                            </div>
                            <div className="invoice-detail" >
                                <span style={{ fontWeight: "bold" }}>Tổng tiền : </span>  {formatMoney(caculatorTotal())} VND
                            </div>
                        </div>
                    </div>
                </div>
                <div className="card">
                    <div className="card-header">
                        <button className="btn btn-success" onClick={() => {
                            handleOpenChoose()
                        }}>Thêm món</button>

                        <div className="card-tools">
                            <button type="button" className="btn btn-warning" data-card-widget="collapse" title="Collapse" onClick={openModal2}>
                                Thanh toán
                            </button>

                        </div>
                    </div>
                </div>

                <div className="invoice-content d-flex" style={{ marginTop: 20 }}>
                    <div className="table-responsive">
                        <table className="table table-invoice">
                            <thead>
                                <tr>
                                    <th style={{ fontSize: 18, fontWeight: "bold", color: "red" }}>Sản phẩm</th>
                                    <th className="text-center" style={{ width: "10%" }}>Giá</th>
                                    <th className="text-center" style={{ width: "20%" }}>Đơn vị tính</th>
                                    <th className="text-center" style={{ width: "10%" }}>Số lượng</th>
                                    <th className="text-right" style={{ width: "20%" }}>Tổng cộng</th>
                                    <th className="text-left" style={{ width: "10%" }}>Hoạt động</th>
                                </tr>
                            </thead>
                            <tbody>
                                {order && order.map((item, index) => (
                                    <tr key={index}>
                                        <td style={{ color: "green", fontSize: 20 }}>
                                            {item.productName} <br />
                                        </td>
                                        <td className="text-center">{formatMoney(item.price)}</td>
                                        <td className="text-center">{item.dvt}</td>
                                        <td className="text-center">{item.quantity}</td>
                                        <td className="text-right">{formatMoney((item.price * item.quantity))}</td>
                                        <td className="project-actions text-right">
                                            <div className="d-flex justify-content-between " >

                                                <button className="btn btn-success btn-sm pd-5" onClick={() => {
                                                    setIsUpdate(true)
                                                    openModal1(item)
                                                }}>
                                                    <i className="fas fa-pencil-alt"></i>
                                                    Sửa món
                                                </button>
                                                <button className="btn btn-danger btn-sm" onClick={() => {
                                                    openModal(item.orderID)
                                                }}>
                                                    <i className="fas fa-trash"></i> Xóa
                                                </button>
                                            </div>

                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                    {isDialogOpen && (
                        <Modal isOpen={isDialogOpen} toggle={() => setIsDialogOpen(!isDialogOpen)}>
                            <ModalHeader toggle={() => setIsDialogOpen(!isDialogOpen)}>Thêm món ăn</ModalHeader>
                            <ModalBody>
                                <div className="form-horizontal" style={{
                                    width: "100%",
                                    maxHeight: 600,
                                }}>
                                    <div className="row align-items-center">
                                        <div className="col-md-6">
                                            <input type="text" placeholder='Nhập tên món' style={{
                                                borderWidth: 1,
                                                borderRadius: 3,
                                                padding: 6,
                                                width: "100%",
                                                margin: 20,
                                            }} />
                                        </div>
                                        <div className="col-md-4 ml-2">
                                            <select
                                                className="form-control"
                                                id="dvt"
                                                value={itemCategory}
                                                onChange={(e) => {
                                                    setItemCategory(e.target.value);
                                                }}
                                            >
                                                <option value="" selected>Chọn loại món</option>
                                                {listCategory && listCategory.length > 0 ? listCategory.map((item: any, id: number) => (
                                                    <option value={item.id} key={id}>{item.name}</option>
                                                )) : ""}
                                            </select>
                                        </div>
                                    </div>
                                    {filteredItems && filteredItems.length > 0 ? (
                                        <div>
                                            {filteredItems.map((item, id) => (
                                                <div className="row align-items-center pt-2 pb-3" >
                                                    <div className="col-md-2">
                                                        <img src={item.imgUrl || ""} alt="món ăn" className="img-fluid" />
                                                    </div>
                                                    <div className="col-md-3">
                                                        <p className='m-0'>{item.name}</p>
                                                    </div>
                                                    <div className="col-md-2">
                                                        <p className='m-0'>{formatMoney(item.price)}</p>
                                                    </div>
                                                    <div className="col-md-3">
                                                        <input
                                                            type="number"
                                                            min="1"
                                                            value={itemOrder === item ? quantityOrder : 0}
                                                            onChange={(e: any) => {
                                                                setItemOrder(item);
                                                                setQuantityOrder(e.target.value);
                                                                setProducID(item.id);
                                                            }}
                                                            className='form-control'
                                                        />
                                                    </div>
                                                    <div className="col-md-2">
                                                        <button className="btn btn-primary" onClick={() => {
                                                            openModal1(item)
                                                            handleOrder();
                                                            console.log('check', itemOrder, quantityOrder);
                                                        }}>Chọn</button>
                                                    </div>
                                                </div>
                                            ))}
                                        </div>
                                    ) : null}
                                </div>
                            </ModalBody>
                        </Modal>
                    )}
                </div>
            </div>

            <Modal isOpen={modal} toggle={openModal}>
                <ModalHeader toggle={openModal}>{"Xác nhận xóa! "}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <p>Bạn muốn xóa món ăn này khỏi danh sách order?</p>
                        </div>

                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={() => {
                        deleteItem(idItemDelete);
                    }}>
                        Xóa
                    </Button>
                    <Button color="secondary" onClick={() => openModal()}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>

            <Modal isOpen={modal2} toggle={openModal2}>
                <ModalHeader toggle={openModal2}>{"Xác nhận Thanh toán! "}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <p>Nhấn OK để thanh toán</p>
                        </div>

                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={handleThanhToan}>
                        OK
                    </Button>
                    <Button color="secondary" onClick={() => openModal2()}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>
        </div>
    )
}