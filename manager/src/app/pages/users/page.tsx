'use client'
import { showAlert } from '@/component/utils/alert/alert';
import { AppDispatch } from '@/redux-store/store';
import { createUserListAsync, getStatusUserState, getUserList, getUserListAsync, deleteUserAsync } from '@/redux-store/user-reducer/userSlice';
import Image from 'next/image'
import Link from 'next/link';
import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Modal, ModalHeader, ModalBody, ModalFooter, Button } from 'reactstrap';

export default function User() {
    const dispatch: AppDispatch = useDispatch();
    const userList: any = useSelector(getUserList);
    const status: any = useSelector(getStatusUserState);
    const [users, setUsers] = useState<any[]>([]);
    const [modal1, setModal1] = useState(false);
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [name, setName] = useState("");
    const [phoneNumber, setPhoneNumber] = useState("");
    const [email, setEmail] = useState("");
    const [address, setAddress] = useState("");
    const [birtDay, setBirtDay] = useState("");
    const [idUser, setIdUser] = useState<number>();
    const [isEdit, setIsEdit] = useState(false);
    const [modalDel, setModalDel] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const totalPages = userList.totalPages || 1;
    const role = 'user';
    const toggle1 = () => setModal1(!modal1);
    const openModal1 = () => {
        toggle1();
    }

    useEffect(() => {
        handlePageChange(currentPage);
    }, [currentPage]);

    useEffect(() => {
        if (userList && userList.data) {
            setUsers(userList.data);
        }

    }, [userList, dispatch]);

    const handlePageChange = (page: number) => {
        setCurrentPage(page);
        dispatch(getUserListAsync(page));
    }
    const handleAddUser = async () => {
        const user = {
            username,
            password,
            name,
            role,
            phoneNumber,
            birtDay,
            address,
            email
        }
        await dispatch(createUserListAsync(user));
        if (status == 'idle') {
            showAlert("success", "Thêm nhân viên mới thành công ");
            dispatch(getUserListAsync(currentPage));
            openModal1();
        } else {
            showAlert("error", "Thêm nhân viên mới  bại ");
        }
    }
    const setDataForm = (item: any) => {
        if (item) {
            setUsername(item.username);
            setPassword(item.password);
            setName(item.name);
            setPhoneNumber(item.phoneNumber);
            setEmail(item.email);
            setAddress(item.address);
            setBirtDay(item.birtDay);
            setIdUser(item.id);
            setIsEdit(true);
        }
    }

    const handleCancel = () => {
        setName("");
        setUsername("");
        setPassword("");
        setPhoneNumber("");
        setEmail("");
        setAddress("");
        setBirtDay("");
        setIdUser(0);
        setIsEdit(false);
        openModal1(); // Đóng modal
    };

    const openModalDel = () => {
        toggleDel()
    }

    const handleDeleteTable = () => {
        dispatch(deleteUserAsync(idUser!)).then((response) => {
            if (response?.meta?.requestStatus === 'fulfilled') {
                dispatch(getUserListAsync(currentPage))
                openModalDel()
                showAlert('success', 'Xóa bàn thành công')
            } else {
                showAlert('error', 'Có lỗi khi xóa bàn')
            }
        })
    }

    const toggleDel = () => setModalDel(!modalDel);
    return (
        <div className='content scroll'>
            <div style={{ border: 'none' }}>
                <div className="container-fluid" style={{}}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', borderBottom: '1.5px solid rgb(195 211 210)' }} className='p-3'>
                        <div className="col-sm-6 p-0">
                            <h3 style={{ height: '40px', margin: '0px' }}>Danh sách Nhân viên</h3>
                        </div>
                        <div className="">
                            <button className="btn btn-success" onClick={openModal1}>Thêm nhân viên</button>
                        </div>
                    </div>
                </div>

                <div className="content m-3 card card-body p-0" style={{ height: '78vh' }}>
                    <table className="table table-striped projects">
                        <thead>
                            <tr>
                                <th style={{ width: "5vh" }}>
                                    MNV
                                </th>
                                <th style={{ width: "20%" }}>
                                    Tên nhân viên
                                </th>
                                <th style={{ width: "10%" }}>
                                    Role
                                </th>
                                <th>
                                    Địa chỉ
                                </th>
                                <th>
                                    SĐT
                                </th>
                                <th>
                                    Email
                                </th>
                                <th style={{ width: "15%" }} className="text-center">

                                </th>

                            </tr>
                        </thead>
                        <tbody>
                            {users && users.length > 0 ? users.map((item: any, i: number) => (
                                <tr key={item && item.id ? item.id : null}>
                                    <td style={{ textAlign: 'center', padding: '0px' }}>
                                        {item.id}
                                    </td>
                                    <td>
                                        <a>
                                            {item && item.name ? item.name : "Chưa xác định"}
                                        </a>
                                        <br />
                                    </td>
                                    <td>
                                        {/* <img alt="user" style={{ width: 60, height: 60 }} src={item && item.imgUrl ? item.imgUrl : ""} /> */}
                                        {item && item.role ? item.role : "Chưa xác định"}
                                    </td>
                                    <td className="project_progress">
                                        {item && item.address ? item.address : "Chưa xác định"}
                                    </td>
                                    <td className="project_progress">
                                        {item && item.phoneNumber ? item.phoneNumber : "Chưa xác định"}
                                    </td>
                                    <td className="project_progress">
                                        {item && item.email ? item.email : "Chưa xác định"}
                                    </td>
                                    <td className="project-actions text-right">
                                        <div className="d-flex justify-content-between " >
                                            <button className="btn btn-success btn-sm pd-5" onClick={() => {
                                                openModal1();
                                                setDataForm(item);
                                                setIsEdit(true);
                                            }}>
                                                <i className="fas fa-pencil-alt"></i> Sửa
                                            </button>
                                            <button className='btn btn-danger btn-sm' type="button" onClick={() => {
                                                setIdUser(item.id);
                                                openModalDel()
                                            }}> <i className="fas fa-trash"></i> Xóa</button>
                                        </div>

                                    </td>
                                </tr>
                            )) : ""}
                        </tbody>
                    </table>
                </div>
                <div className="card-footer bg-white p-0">
                    <div className="d-flex justify-content-center align-items-center">
                        <ul className="pagination">
                            <li className={`page-item ${currentPage === 1 ? 'disabled' : ''}`}>
                                <button
                                    className="page-link"
                                    onClick={() => handlePageChange(currentPage - 1)}
                                >
                                    &#60;
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
                                    &#62;
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>

            </div>
            <Modal isOpen={modal1} toggle1={openModal1}>
                <ModalHeader toggle1={openModal1}>{isEdit == false ? 'Thêm nhân viên mới' : 'Chỉnh sửa thông tin nhân viên'}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Tên nhân viên</label>
                            <div className="col-sm-8">
                                <input
                                    className="form-control"
                                    id="name"
                                    value={name}
                                    onChange={(e) => {
                                        setName(e.target.value)
                                    }}
                                />
                            </div>
                        </div>
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Tên tài khoản</label>
                            <div className="col-sm-8">
                                <input
                                    className="form-control"
                                    id="username"
                                    value={username}
                                    onChange={(e) => {
                                        setUsername(e.target.value)
                                    }}
                                />
                            </div>
                        </div>
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Mật khẩu</label>
                            <div className="col-sm-8">
                                <input
                                    className="form-control"
                                    id="name"
                                    value={password}
                                    onChange={(e) => {
                                        setPassword(e.target.value)
                                    }}
                                />
                            </div>
                        </div>
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Số điện thoại</label>
                            <div className="col-sm-8">
                                <input
                                    className="form-control"
                                    id="name"
                                    value={phoneNumber}
                                    onChange={(e) => {
                                        setPhoneNumber(e.target.value)
                                    }}
                                />
                            </div>
                        </div>
                        {isEdit && isEdit === true ? <>
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label">Email</label>
                                <div className="col-sm-8">
                                    <input
                                        className="form-control"
                                        id="email"
                                        value={email}
                                        onChange={(e) => {
                                            setEmail(e.target.value)
                                        }}
                                    />
                                </div>
                            </div>
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label">Địa chỉ</label>
                                <div className="col-sm-8">
                                    <input
                                        className="form-control"
                                        id="address"
                                        value={address}
                                        onChange={(e) => {
                                            setAddress(e.target.value)
                                        }}
                                    />
                                </div>
                            </div>
                            <div className="form-group row">
                                <label className="col-sm-4 col-form-label">Sinh nhật</label>
                                <div className="col-sm-8">
                                    <input
                                        className="form-control"
                                        id="birthDay"
                                        value={birtDay}
                                        onChange={(e) => {
                                            setBirtDay(e.target.value)
                                        }}
                                    />
                                </div>
                            </div>
                        </> : ""}
                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={handleAddUser}>
                        Lưu
                    </Button>
                    <Button color="secondary" onClick={() => { openModal1(); handleCancel() }}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>

            <Modal isOpen={modalDel} toggle={openModalDel}>
                <ModalHeader toggle1={openModal1}>{"Xác nhận xóa người dùng"}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <h4>Bạn có chắc chắn muốn xóa người dùng này không? </h4>
                            <div>Sau khi tài khoản người dùng, tài khoản sẽ bị xóa vĩnh viễn và không thể khôi phục lại được nữa</div>
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
        </div>
    )
}
