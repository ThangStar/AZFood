'use client'
import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useLayoutEffect } from 'react';
import Link from "next/link";
import { createMenuItemAsync, deleteMenuItemAsync, getCategoryList, getCategoryListAsync, getMenuItemListAsync, getMenuItemtList, getSearchMenuListAsync } from '@/redux-store/menuItem-reducer/menuItemSlice';
import { AppDispatch } from '@/redux-store/store';
import { Modal, ModalHeader, ModalBody, ModalFooter, Button } from 'reactstrap';
import { getDVTList, getDvtListAsync } from '@/redux-store/kho-reducer/nhapHangSlice';
import { showAlert } from '@/component/utils/alert/alert';
import formatMoney from '@/component/utils/formatMoney';


export default function MunuItems() {
    const dispatch: AppDispatch = useDispatch();
    const menuItemList: any = useSelector(getMenuItemtList);
    const categoryList: any = useSelector(getCategoryList);
    const dvtList: any = useSelector(getDVTList);


    const [menuItems, setMenuItems] = useState<any[]>([]);
    const [modal, setModal] = useState(false);
    const [modal1, setModal1] = useState(false);
    const [itemName, setItemName] = useState("");
    const [itemPrice, setItemPrice] = useState("");
    const [itemDVT, setItemDVT] = useState("");
    const [itemCategory, setItemCategory] = useState("");
    const [idItemDelete, setIdItemDelete] = useState<number>(0);
    const [idItem, setIdItem] = useState<number>(0);
    const [listCategory, setListCategory] = useState<string[]>([]);
    const [listDvt, setListDvt] = useState<string[]>([]);
    const [currentPage, setCurrentPage] = useState(1);
    const [searchName, setSearchName] = useState("")

    const totalPages = menuItemList.totalPages || 1;

    useEffect(() => {
        handlePageChange(currentPage);
        dispatch(getCategoryListAsync());
        dispatch(getDvtListAsync());
    }, [dispatch, currentPage]);
    const handlePageChange = (page: number) => {
        setCurrentPage(page);
        dispatch(getMenuItemListAsync(page));
    };
    useEffect(() => {

        if (menuItemList && menuItemList.data) {
            setMenuItems(menuItemList.data);
        }
        if (categoryList && categoryList.resultRaw) {
            setListCategory(categoryList.resultRaw);
        }
        if (dvtList && dvtList.resultRaw) {
            setListDvt(dvtList.resultRaw);
        }

    }, [menuItemList, categoryList, dvtList]);

    const toggle = () => setModal(!modal);
    const openModal = (data: any = null) => {
        if (data) {
            setIdItem(data.id);
            setItemName(data.name);
            setItemPrice(data.price);
            setItemCategory(data.category);
            setItemDVT(data.dvtID);
        }
        toggle();
    }
    const toggle1 = () => setModal1(!modal1);
    const openModal1 = (id: any = null) => {
        setIdItemDelete(id);
        toggle1();
    }

    const addMenuItem = () => {
        const data = {
            name: itemName,
            price: itemPrice,
            category: itemCategory,
            status,
            dvtID: itemDVT,
            id: idItem,
        }
        dispatch(createMenuItemAsync(data));
        handlePageChange(currentPage);
        showAlert("success", " Thêm món thành công");
        toggle();
    }

    const deleteItem = (id: number) => {
        if (id) {
            dispatch(deleteMenuItemAsync(id));
            showAlert("success", " Xóa món ăn thành công");
            handlePageChange(currentPage);
            toggle1();
        } else {
            showAlert("error", " Không tìm thấy sản phẩm");
        }
    };

    const onSearchChange = (searchName: any) => {
        setSearchName(searchName);
        dispatch(getSearchMenuListAsync(searchName));
    }

    return (
        <>
            <div className="main-header card" >
                <div className="card-header">
                    <div className="container-fluid">
                        <div className="row mb-2">
                            <div className="col-sm-6">
                                <h1>Danh sách món</h1>
                            </div>
                            <div className="col-sm-6">
                                <ol className="breadcrumb float-sm-right">
                                    <li className="breadcrumb-item"><a href="#">Home</a></li>
                                    <li className="breadcrumb-item active">Danh sách món</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>

                <div className="content">

                    <div className="card">
                        <div className="card-header">
                            <button className="btn btn-success" onClick={() => {
                                openModal()
                            }}><i className="fas fa-plus-circle mr-2"></i>Thêm món</button>

                            <div className="card-tools flex items-center">
                                <form role="search">
                                    <input
                                        type="text"
                                        value={searchName}
                                        onChange={(e)=>onSearchChange(e.target.value)}
                                        placeholder="Tìm kiếm món ăn..."
                                        className='form-control'
                                    />
                                </form>

                                <button type="button" className="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                    <i className="fas fa-minus"></i>
                                </button>
                                <button type="button" className="btn btn-tool" data-card-widget="remove" title="Remove">
                                    <i className="fas fa-times"></i>
                                </button>
                            </div>
                        </div>
                        <div className="card-body p-0">
                            <table className="table table-striped projects">
                                <thead>
                                    <tr>
                                        <th style={{ width: "1%" }}>
                                            STT
                                        </th>
                                        <th style={{ width: "20%" }}>
                                            Tên Món
                                        </th>
                                        <th style={{ width: "10%" }}>
                                            Hình Ảnh
                                        </th>
                                        <th>
                                            Giá
                                        </th>
                                        <th>
                                            Loại Món
                                        </th>
                                        <th>
                                            Đơn Vị Tính
                                        </th>
                                        <th>
                                            Trạng thái / Số lượng
                                        </th>
                                        <th style={{ width: "15%" }} className="text-center">
                                            Actions
                                        </th>

                                    </tr>
                                </thead>
                                <tbody>
                                    {menuItems && menuItems.length > 0 ? menuItems.map((item: any, i: number) => (
                                        <tr key={item && item.id ? item.id : null}>
                                            <td>
                                                {i + 1}
                                            </td>
                                            <td>
                                                <a>
                                                    {item && item.name ? item.name : null}
                                                </a>
                                                <br />
                                            </td>
                                            <td>
                                                <img alt="món ăn" style={{ width: 60, height: 60 }} src={item && item.imgUrl ? item.imgUrl : ""} />
                                            </td>
                                            <td className="project_progress" style={{}}>
                                                {item && item.price ? `${formatMoney(item.price)} vnd` : null}
                                            </td>
                                            <td className="project_progress">
                                                {item && item.category_name ? item.category_name : ""}
                                            </td>
                                            <td className="project_progress">
                                                {item && item.dvt_name ? item.dvt_name : null}
                                            </td>
                                            <td className="project_progress">
                                                {item && item.status === 1 ? "Còn hàng" : item.status == 2 ? "Hết hàng" : item.quantity == 0 ? "Hết hàng" : item.quantity}
                                            </td>
                                            <td className="project-actions text-right">
                                                <div className="d-flex justify-content-between " >
                                                    <a className="btn btn-primary btn-sm" href="#">
                                                        <i className="fas fa-folder mr-1"></i> View
                                                    </a>
                                                    <button className="btn btn-success btn-sm pd-5" onClick={() => {
                                                        openModal(item)
                                                    }}>
                                                        <i className="fas fa-pencil-alt mr-1"></i> Sửa
                                                    </button>
                                                    <button className="btn btn-danger btn-sm " onClick={() => {
                                                        openModal1(item.id)
                                                    }}>
                                                        <i className="fas fa-trash  mr-1"></i> Xóa
                                                    </button>
                                                </div>

                                            </td>
                                        </tr>
                                    )) : ""}


                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>

                <Modal isOpen={modal} toggle={openModal}>
                    <ModalHeader toggle={openModal}>{"Thêm Món Mới"}</ModalHeader>
                    <ModalBody>
                        <form className="form-horizontal">
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label">Loại món </label>
                                <div className="col-sm-8">
                                    <select
                                        className="form-control"
                                        id="dvt"
                                        value={itemCategory}
                                        onChange={(e) => {
                                            setItemCategory(e.target.value)
                                        }}
                                    >
                                        <option value="" selected>Chọn loại món</option>
                                        {listCategory && listCategory.length > 0 ? listCategory.map((item: any, id: number) => (
                                            <option value={item.id}>{item.name}</option>


                                        )) : ""}
                                    </select>

                                </div>
                            </div>
                            {itemCategory != "" ?
                                <>
                                    <div className="form-group row">
                                        <label className="col-sm-4 col-form-label">Tên món ăn </label>
                                        <div className="col-sm-8">

                                            <input
                                                className="form-control"
                                                id="name"
                                                value={itemName}
                                                onChange={(e) => {
                                                    setItemName(e.target.value)

                                                }}
                                            />


                                        </div>
                                    </div>
                                    <div className="form-group row">
                                        <label className="col-sm-4 col-form-label">Giá</label>
                                        <div className="col-sm-8">

                                            <input
                                                className="form-control"
                                                id="name"
                                                value={itemPrice}
                                                onChange={(e) => {
                                                    setItemPrice(e.target.value)
                                                }}
                                            />


                                        </div>
                                    </div>

                                    <div className="form-group row">
                                        <label className="col-sm-4 col-form-label">Đơn vị tính</label>
                                        <div className="col-sm-8">

                                            <select
                                                className="form-control"
                                                id="dvt"
                                                value={itemDVT}
                                                onChange={(e) => {
                                                    setItemDVT(e.target.value)
                                                }}
                                            >
                                                <option value=" ">Chọn đơn vị tính</option>

                                                {listDvt && listDvt.length > 0 ? listDvt.map((item: any, id: number) => (
                                                    <option value={item.id}>{item.tenDVT}</option>


                                                )) : ""}
                                            </select>

                                        </div>
                                    </div></> : " "}

                        </form>
                    </ModalBody>
                    <ModalFooter>
                        <Button color="primary" onClick={addMenuItem}>
                            Lưu
                        </Button>
                        <Button color="secondary" onClick={() => openModal()}>
                            Hủy
                        </Button>
                    </ModalFooter>
                </Modal>

                <Modal isOpen={modal1} toggle1={openModal1}>
                    <ModalHeader toggle1={openModal1}>{"Xác nhận xóa "}</ModalHeader>
                    <ModalBody>
                        <form className="form-horizontal">
                            <div className="form-group row">
                                <h3>Bạn muốn xóa món ăn này?</h3>
                            </div>

                        </form>
                    </ModalBody>
                    <ModalFooter>
                        <Button color="primary" onClick={() => {
                            deleteItem(idItemDelete);
                        }}>
                            Xóa
                        </Button>
                        <Button color="secondary" onClick={() => openModal1()}>
                            Hủy
                        </Button>
                    </ModalFooter>
                </Modal>

            </div>
            <div className="d-flex justify-content-center align-items-center">
                <ul className="pagination">
                    <li className={`page-item ${currentPage === 1 ? 'disabled' : ''}`}>
                        <button
                            className="page-link"
                            onClick={() => handlePageChange(currentPage - 1)}
                        >
                            Previous
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
                            Next
                        </button>
                    </li>
                </ul>
            </div>
        </>
    )
}
