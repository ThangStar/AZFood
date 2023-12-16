'use client'
import { showAlert } from "@/component/utils/alert/alert";
import formatMoney from "@/component/utils/formatMoney";
import { createPriceForProdAsync, deletePriceAsync, getItemtList, getMenuListAsync, getPriceForSize, getPriceList, getSizeList, getSizeListAsync, updatePriceForProdAsync } from "@/redux-store/menuItem-reducer/menuItemSlice";
import { AppDispatch } from "@/redux-store/store";
import { log } from "console";
import Link from "next/link";
import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Modal, ModalHeader, ModalBody, ModalFooter, Button, Alert } from 'reactstrap';

const MenuItemDetail = () => {
    const dispatch: AppDispatch = useDispatch();

    const priceList: any = useSelector(getPriceList);
    const menuItemList: any = useSelector(getItemtList);
    const menuSizeList: any = useSelector(getSizeList);


    const [modal1, setModal1] = useState(false);
    const [modal, setModal] = useState(false);
    const [isEdit, setIsEdit] = useState(false);
    const [idItemDelete, setIdItemDelete] = useState<number>(0);
    const [prodPrice, setProductPrice] = useState("");
    const [productID, setProductID] = useState("");
    const [size, setSize] = useState("");
    const [sizeValue, setSizeValue] = useState(0);
    const [idItem, setIdItem] = useState(0);

    const [listPriceProd, setListPriceProd] = useState<any[]>([]);
    const [listMenuItem, setListMenuItem] = useState<any[]>([]);
    const [listSizeProd, setListSizeProd] = useState<any[]>([]);


    useEffect(() => {
        const fetchData = async () => {
            await dispatch(getPriceForSize());
            await dispatch(getMenuListAsync());
            await dispatch(getSizeListAsync());
        }
        fetchData();
    }, [dispatch]);
    const toggle1 = () => setModal1(!modal1);
    const openModal1 = (id: any = null) => {
        setIdItemDelete(id);
        toggle1();
    }
    const toggle = () => setModal(!modal);
    const openModal = (item: any) => {
        if (item && item !== '') {
            setSize(item.SizeName);
            setSizeValue(item.products_size);
            setProductID(item.product_id);
            setProductPrice(item.product_price);
            setIdItem(item.id);
            setIsEdit(true);
        }

        toggle()
    }
    useEffect(() => {
        if (priceList && priceList.data) {
            // Group data by product name
            const groupedData: any = {};
            priceList.data.forEach((item: any) => {
                const productName = item.ProductName;
                if (!groupedData[productName]) {
                    groupedData[productName] = [];
                }
                // Check if there is a similar item in the group
                const similarItem = groupedData[productName].find((groupedItem: any) => groupedItem.product_price === item.product_price);
                if (!similarItem) {
                    groupedData[productName].push(item);
                }
            });
            // Flatten the grouped data
            const flattenedData: any = Object.values(groupedData).reduce((acc: any, val) => acc.concat(val), []);
            setListPriceProd(flattenedData);
        };

    }, [priceList]);
    useEffect(() => {
        if (menuItemList && menuItemList.data) {
            const productsWithPriceZero = menuItemList.data.filter((product: any) => product.price === 0);
            setListMenuItem(productsWithPriceZero);
        };
        if (menuSizeList && menuSizeList.data) {
            setListSizeProd(menuSizeList.data);
        };
    }, [menuItemList, menuSizeList]);

    const handleDelete = async (id: number) => {
        if (!id) {
            return;
        }

        const resp = await dispatch(deletePriceAsync(id));
        if (resp.payload) {
            showAlert('success', 'Xoá thành công');
            dispatch(getPriceForSize());
            toggle1();
        }
    }
    const handleInputChange = (e: any) => {
        const inputValue = e.target.value;
        setSize(inputValue);
        if (inputValue.toLowerCase().includes('lớn')) {
            setSizeValue(3);
        } else if (inputValue.toLowerCase().includes('nhỏ')) {
            setSizeValue(1);
        } else if (inputValue.toLowerCase().includes('trung bình')) {
            setSizeValue(2);
        } else {
            setSizeValue(0);
        }
    };
    const handleAdd = async () => {
        const parsedPrice = parseFloat(prodPrice);
        const parsedID = parseFloat(productID);
        const data = {
            productID: parsedID,
            sizeValue,
            size,
            prodPrice: parsedPrice,
            id: idItem
        }

        if (!isEdit) {
            const resp = await dispatch(createPriceForProdAsync(data));
            if (resp.payload) {
                showAlert('success', 'Thêm thành công');
            } else {
                showAlert('error', 'Thêm thất bại');
            }
        } else {
            const resp = await dispatch(updatePriceForProdAsync(data));
            if (resp.payload) {
                showAlert('success', 'Sửa thành công');
                setIsEdit(false);
            } else {
                showAlert('error', 'Phần này đã tồn tại');
            }
        }
        dispatch(getPriceForSize());
        toggle();

    }

    return (
        <div>
            <div className="container-fluid">
                <div className="p-3" style={{ display: 'flex', justifyContent: 'space-between', borderBottom: '1.5px solid rgb(195 211 210)' }}>
                    <h3 className='m-0' style={{ height: '40px' }}>Quản lý Phần món ăn</h3>
                    <button className="btn btn-success" onClick={() => { openModal('') }}>Thêm phần</button>
                </div>
            </div>

            <div className="content px-3">
                <div className="card p-0">
                    <table className="table ">
                        <thead>
                            <tr>
                                <th style={{ width: "1%" }}>
                                    STT
                                </th>
                                <th style={{ width: "20%" }}>
                                    Tên hàng
                                </th>
                                <th style={{ width: "20%" }}>
                                    Tên Phần
                                </th>
                                <th>
                                    Đơn giá(vnd)
                                </th>
                                <th style={{ width: "14%" }}>
                                    Tuỳ chỉnh
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            {listPriceProd && listPriceProd.length > 0 ? listPriceProd.map((item: any, i: number) => (
                                <tr key={item && item.id ? item.id : null}>
                                    <td>
                                        {i + 1}
                                    </td>
                                    <td>
                                        <a>
                                            {item && item.ProductName ? item.ProductName : null}
                                        </a>
                                        <br />
                                    </td>
                                    <td className="project_progress">
                                        {item && item.SizeName ? item.SizeName : null}
                                    </td>
                                    <td className="project_progress">
                                        {item && item.product_price ? formatMoney(item.product_price) : ""}
                                    </td>
                                    <td className="project-actions text-right">
                                        <div className="d-flex justify-content-between " >

                                            <button className="btn btn-success btn-sm pd-5" onClick={() => {
                                                openModal(item);
                                            }}>
                                                <i className="fas fa-pencil-alt"></i> Sửa
                                            </button>
                                            <button className="btn btn-danger btn-sm me-2" onClick={() => {
                                                openModal1(item.id)
                                            }}>
                                                <i className="fas fa-trash"></i> Xóa
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            )) : ""}


                        </tbody>
                    </table>
                </div>
            </div>

            <Modal isOpen={modal} toggle={openModal}>
                <ModalHeader toggle={openModal}>{"Thêm phần "}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Tên hàng </label>
                            <div className="col-sm-8">

                                <select
                                    className="form-control"
                                    id="productID"
                                    value={productID}
                                    onChange={(e) => {
                                        setProductID(e.target.value);
                                    }}
                                >
                                    <option value=""></option>
                                    {listMenuItem && listMenuItem.length > 0 ? listMenuItem.map((item: any, id: number) => (
                                        <option key={item.id} value={item.id}>{item.name}</option>
                                    )) : ""}
                                </select>

                            </div>
                        </div>
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Tên phần  </label>
                            <div className="col-sm-4">
                                <select
                                    className="form-control"
                                    id="productID"
                                    value={sizeValue}
                                    onChange={(e) => {
                                        setSizeValue(parseInt(e.target.value, 0));
                                    }}
                                >
                                    <option value="">Chọn</option>
                                    {listSizeProd && listSizeProd.length > 0 ? listSizeProd.map((item: any, id: number) => (
                                        <option key={item.id} value={item.id}>{item.size_name}
                                        </option>
                                    )) : ""}
                                </select>
                            </div>
                            <div className="col-sm-4">
                                <input
                                    type="text"
                                    placeholder="Nhập"
                                    className="form-control"
                                    id="quantity"
                                    value={size}
                                    onChange={handleInputChange} />
                            </div>

                        </div>
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Giá </label>
                            <div className="col-sm-8">
                                <input
                                    type="text"
                                    className="form-control"
                                    id="quantity"
                                    value={prodPrice}
                                    onChange={(e) => {
                                        setProductPrice(e.target.value);
                                    }} />

                            </div>
                        </div>

                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="secondary" onClick={() => {
                        openModal('')
                        // setDataForm(" ");
                    }}>
                        Hủy
                    </Button>
                    <Button color="danger" onClick={() => {
                        handleAdd();
                    }}>
                        Lưu
                    </Button>
                </ModalFooter>
            </Modal>

            <Modal isOpen={modal1} toggle={openModal1}>
                <ModalHeader toggle1={openModal1}>{"Xác nhận xóa "}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <h4>Bạn có chắc chắn muốn xóa không? </h4>
                            <div>Sau khi xóa sẽ bị xóa vĩnh viễn và không thể khôi phực lại được nữa</div>
                        </div>
                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="secondary" onClick={() => {
                        openModal1()
                        // setDataForm(" ");
                    }}>
                        Hủy
                    </Button>
                    <Button color="danger" onClick={() => {
                        handleDelete(idItemDelete);
                    }}>
                        Đồng ý xóa
                    </Button>
                </ModalFooter>
            </Modal>
        </div>

    )
}
export default MenuItemDetail;