import Link from "next/link";
import '../LeftSideBar/LeftSideBar.css'
import TableRestaurantSharpIcon from '@mui/icons-material/TableRestaurantSharp';
import RecentActorsSharpIcon from '@mui/icons-material/RecentActorsSharp';
import RamenDiningSharpIcon from '@mui/icons-material/RamenDiningSharp';
import ReceiptLongSharpIcon from '@mui/icons-material/ReceiptLongSharp';
import FactCheckSharpIcon from '@mui/icons-material/FactCheckSharp';
import BackupTableSharpIcon from '@mui/icons-material/BackupTableSharp';
import KeySharpIcon from '@mui/icons-material/KeySharp';
import SettingsSharpIcon from '@mui/icons-material/SettingsSharp';
import LogoutSharpIcon from '@mui/icons-material/LogoutSharp';
import BarChartSharpIcon from '@mui/icons-material/BarChartSharp';
import { AppDispatch } from "@/redux-store/store";
import { useDispatch } from "react-redux";
import { changePassAsync } from "@/redux-store/login-reducer/loginSlice";
import { useState } from "react";
import { Button, Modal, ModalBody, ModalFooter, ModalHeader } from "reactstrap";
import { showAlert } from "../utils/alert/alert";
import { useRouter } from 'next/router';
type ButtonProps = {
    onLogout: () => void; // Định nghĩa kiểu cho prop onPress
}

const AdminPage: React.FC<ButtonProps> = ({ onLogout }) => {
    const dispatch: AppDispatch = useDispatch()
    const [modal, setModal] = useState(false)
    const [oldPassword, setOldPassword] = useState('')
    const [newPassword, setNewPassword] = useState('')

    const toggle = () => setModal(!modal)

    const openModal = () => {
        toggle()
    }

    const changePassword = () => {
        const data = {
            oldPassword: oldPassword,
            password: newPassword,
        }
        dispatch(changePassAsync(data))
            .then((response: any) => {
                if (response.error) {
                    showAlert('error', 'Đổi mật khẩu thất bại')
                } else {
                    showAlert('success', 'Đổi mật khẩu thành công')
                    toggle()
                }
            })
    }

    return (
        <div className="p-3">
            <div>
                <div className="d-flex mb-3" style={{ alignItems: 'center', justifyContent: 'center'}}>
                    <img src="\img\logo\chicken.png" alt="" style={{ height: '40px' }} />
                    <span className="brand-text fs-4 col-sm-8 fw-bolder" style={{ color: '#272343' }}>AZFOOD</span>
                </div>
                <div className="management" style={{ color: 'whitesmoke', borderTop: '1.5px solid rgb(195 211 210)'}}>
                    <div className="tittle mt-3" style={{ color: '#272343' }}>
                        QUẢN LÍ
                    </div>
                    <nav>
                        <ul className="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                            <Link href="/pages/table" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex" >
                                    <TableRestaurantSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Bàn</p>
                                </div>
                            </Link>
                            <Link href="/pages/users" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <RecentActorsSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Nhân viên</p>
                                </div>
                            </Link>
                            <Link href="/pages/menuItem" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <RamenDiningSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Sản phẩm</p>
                                </div>
                            </Link>
                            <Link href="/pages/kho" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <ReceiptLongSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Nhập hàng</p>
                                </div>
                            </Link>
                            <Link href="/pages/invoice" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <FactCheckSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Hóa đơn</p>
                                </div>
                            </Link>
                            <Link href="/" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <BarChartSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>
                                        Thống kê
                                    </p>
                                </div>
                            </Link>
                            <Link href="/pages/checkin-history" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <BackupTableSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>
                                        Chấm công
                                    </p>
                                </div>
                            </Link>
                        </ul>
                    </nav>
                </div>
                <div className="line" style={{ borderBottom: '1.5px solid rgb(195 211 210)', padding: '10px' }}></div>
                <div className="management mt-3" style={{ color: '#272343' }}>
                    <div>
                        CÀI ĐẶT
                    </div>
                    <nav>
                        <ul className="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                            <div onClick={() => openModal()} style={{ padding: '10px', borderRadius: '10px', cursor: 'pointer' }} className="link">
                                <div className="d-flex" >
                                    <KeySharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Mật khẩu</p>
                                </div>
                            </div>
                            <Link href="#" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <SettingsSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Hệ thống</p>
                                </div>
                            </Link>
                            <div onClick={() => onLogout()} style={{ padding: '10px', borderRadius: '10px', cursor: "pointer" }} className="link">
                                <div className="d-flex">
                                    <LogoutSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Đăng xuất</p>
                                </div>
                            </div>
                        </ul>
                    </nav>
                </div>
            </div>

            <Modal isOpen={modal} toggle={openModal}>
                <ModalHeader toggle={openModal}>{"Thay đổi mật khẩu"}</ModalHeader>
                <ModalBody>
                    <form className="form-horizontal">
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Mật khẩu: </label>
                            <div className="col-sm-8">
                                <input className="form-control" id="oldPassword" type="password"
                                    value={oldPassword} onChange={(e) => setOldPassword(e.target.value)} />
                            </div>
                        </div>
                        <div className="form-group row">
                            <label className="col-sm-4 col-form-label">Mật khẩu mới: </label>
                            <div className="col-sm-8">
                                <input className="form-control" id="newPassword" type="password"
                                    value={newPassword} onChange={(e) => setNewPassword(e.target.value)} />
                            </div>
                        </div>
                    </form>
                </ModalBody>
                <ModalFooter>
                    <Button color="primary" onClick={() => changePassword()}>
                        Xác nhận
                    </Button>
                    <Button color="secondary" onClick={() => openModal()}>
                        Hủy
                    </Button>
                </ModalFooter>
            </Modal>
        </div>
    )
}
export default AdminPage;
