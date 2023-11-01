'use client'
import '../table-details/page.css'
import { showAlert } from '@/component/utils/alert/alert';
import { formatDateTime } from '@/component/utils/formatDate';
import formatMoney from '@/component/utils/formatMoney';
import { getCategoryList, getCategoryListAsync, getItemtList, getMenuListAsync, getMenuItemListAsync, getMenuItemtList } from '@/redux-store/menuItem-reducer/menuItemSlice';
import { createOrderAsync, incrementProductAsync, deleteOrderAsync, getOrder, getOrderInTableListAsync, getStatus, payBillAsync, updateOrderAsync } from '@/redux-store/order-reducer/orderSlice';
import { AppDispatch } from '@/redux-store/store';
import { useSearchParams } from 'next/navigation';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Modal, ModalHeader, ModalBody, ModalFooter, Button } from 'reactstrap';
import { useSocket } from "@/socket/io.init"
import { log } from 'console';


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
    const itemList: any = useSelector(getMenuItemtList);
    const orders: any = useSelector(getOrder);
    const menuItems: any = useSelector(getItemtList);
    const statusRD: any = useSelector(getStatus);

    const categoryList: any = useSelector(getCategoryList);
    const [listItem, setlistItem] = useState<any[]>([]);
    const [order, setOrder] = useState<any[]>([]);
    const [itemMenus, setItemMenus] = useState<any[]>([]);
    const [itemCategory, setItemCategory] = useState("");
    const [listCategory, setListCategory] = useState<string[]>([]);

    const [quantityOrder, setQuantityOrder] = useState<number>(1);
    const [productID, setProducID] = useState();
    const [userID, setUserID] = useState();
    const [orderID, setOrderID] = useState();
    const [idItemDelete, setIdDelete] = useState();
    const [nameUpdate, setNameUpdate] = useState("");
    const [itemOrder, setItemOrder] = useState<any>([]);

    const [payMethod, setPayMethod] = useState<number>(1)

    const [currentPage, setCurrentPage] = useState(1)

    useEffect(() => {

        dispatch(getMenuListAsync());
    }, [dispatch]);

    useEffect(() => {
        if (menuItems && menuItems.data) {
            setlistItem(menuItems.data);
        }
    }, [menuItems]);

    const toggle1 = () => setModal1(!modal1);
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
        const fetchData = async () => {
            await dispatch(getOrderInTableListAsync(tableID));
            await dispatch(getMenuListAsync());
        }
        fetchData();
    }, []);

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
    const caculatorTotal = () => {
        let totalAll = 0;
        order.forEach(item => {
            totalAll += item.price * item.quantity
        });
        return totalAll;
    }
    const handleOrder = async (id: number) => {
        console.log(id);
        const data = {
            userID: userID,
            tableID: tableID,
            productID: id,
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

    const handleIncrement = async (id: number) => {
        console.log('ttt', quantityOrder, id);
        const data = {
            quantity: quantityOrder + 1,
            productID: id,
        }

        console.log('data', data);
        await dispatch(incrementProductAsync({ data }));
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

    const handleThanhToan = async () => {
        const data = {
            id: tableID,
            payMethod
        }
        await dispatch(payBillAsync(data)); //step 1:  gọi hàm thêm xoá sửa thì cho await vô 
        showAlert("success", "Thanh toán thành công");
        dispatch(getOrderInTableListAsync(tableID));//step 2: sau đó gọi hàm getList
        toggle2();
    }
    return (
        <div style={{ display: 'flex' }}>
            <div style={{ width: '38%', padding: '10px', marginRight: '10px', height: '100%' }}>
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
                {listItem && listItem.length > 0 ? (
                    <div className="grid-container">
                        {listItem.map((item, id) => (
                            <div
                                className="grid-item"
                                key={id}
                                style={{ backgroundImage: `url(${item.imgUrl})`, height: '150px', padding: '0px', display: 'flex', alignItems: 'end' }}
                                onClick={() => {
                                    handleOrder(item.id);
                                }}
                            >
                                <div style={{ width: '100%', padding: '10px 0px 10px 0px', backgroundColor: 'white', opacity: '0.9' }}>
                                    <h6 className='m-0'>{item.name}</h6>
                                </div>
                            </div>
                        ))}
                    </div>
                ) : null}
            </div>

            <div style={{ marginRight: '15px', border: 'none', width: '62%' }}>
                <div >
                    <div className="col-md-10 flex justify-content-between mt-2 mb-4" >
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
                            <button className="btn btn-danger btn-sm" onClick={() => {
                                openModal2()
                            }}>
                                <i className="fas fa-trash"></i> thanh toán
                            </button>
                        </div>
                    </div>
                </div>

                <div className="invoice-content d-flex" style={{ marginTop: 20 }}>
                    <div className="table-responsive">
                        <table className="table table-invoice">
                            <thead>
                                <tr>
                                    <th style={{ fontSize: 18, fontWeight: "bold", color: "red", width: '30%' }}>Sản phẩm</th>
                                    <th className="text-center" style={{ width: "10%" }}>Giá</th>
                                    <th className="text-center" style={{ width: "20%" }}>Số lượng</th>
                                    <th className="text-center" style={{ width: "20%" }}>Tổng cộng</th>
                                    <th className="text-left" style={{ width: "10%" }}></th>
                                </tr>
                            </thead>
                            <tbody>
                                {order && order.map((item, index) => (
                                    <tr key={index}>
                                        <td style={{ color: "green", fontSize: 20 }}>
                                            <h6>{item.productName} ({item.dvt})</h6>
                                        </td>
                                        <td className="text-center">{formatMoney(item.price)}</td>
                                        <td className="text-center">
                                            <button className="btn btn-outline-dark mr-2">-</button>
                                            {item.quantity}
                                            <button className="btn btn-outline-dark ml-2" onClick={() => {

                                                handleIncrement(item.productID)
                                            }}>+</button>
                                        </td>
                                        <td className="text-center">{formatMoney((item.price * item.quantity))}</td>
                                        <td className="project-actions text-left ">
                                            <div className="d-flex justify-content-between">
                                                <div className="btn-group">
                                                    <button className="btn btn-secondary btn-sm">
                                                        <i className="fas fa-trash"></i>
                                                    </button>
                                                    <div className="popup">
                                                        <div className="popup-content">
                                                            <button className="btn btn-sm" style={{ width: '100%' }} onClick={() => {
                                                                openModal(item.orderID)
                                                            }}>
                                                                <i className="fas fa-trash"></i> Xóa sản phẩm
                                                            </button>
                                                            <br />
                                                            <button className="btn btn-sm" style={{ width: '100%' }}>
                                                                <i className="fa-solid fa-pencil-mechanical"></i> Ghi chú
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
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