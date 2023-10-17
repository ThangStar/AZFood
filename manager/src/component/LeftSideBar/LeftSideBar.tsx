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

const AdminPage = () => {
    return (
        <div className="main-sidebar" style={{display: 'flex', alignItems: 'flex-end'}}>
            <div style={{ backgroundColor: '#E3F6F5', padding: '0px', height: 'calc(100vh - 60px)', borderTop: '1.5px solid rgb(195 211 210)', borderRight: '1.5px solid rgb(195 211 210)'}}>
                <div className="management mt-4" style={{ color: 'whitesmoke' }}>
                    <div className="tittle ml-3" style={{color:'#272343'}}>
                        QUẢN LÍ
                    </div>
                    <nav className="mt-2 pl-3 pr-3">
                        <ul className="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                            <Link href="/pages/table" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex" >
                                    <TableRestaurantSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Danh sách bàn</p>
                                </div>
                            </Link>
                            <Link href="/pages/users" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <RecentActorsSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Danh sách nhân viên</p>
                                </div>
                            </Link>
                            <Link href="/pages/menuItem" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <RamenDiningSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Danh sách món ăn</p>
                                </div>
                            </Link>
                            <Link href="/pages/kho" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <ReceiptLongSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Phiếu nhập hàng</p>
                                </div>
                            </Link>
                            <Link href="/pages/invoice" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <FactCheckSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Danh sách hóa đơn</p>
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
                                        Bảng chấm công
                                    </p>
                                </div>
                            </Link>
                        </ul>
                    </nav>
                </div>
                <div className="line" style={{ borderBottom: '1.5px solid rgb(195 211 210)', padding: '10px' }}></div>
                <div className="management mt-4" style={{ color: '#272343' }}>
                    <div className="tittle ml-3">
                        CÀI ĐẶT
                    </div>
                    <nav className="mt-2 pl-3 pr-3">
                        <ul className="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                            <Link href="#" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex" >
                                    <KeySharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Mật khẩu</p>
                                </div>
                            </Link>
                            <Link href="#" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <SettingsSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Hệ thống</p>
                                </div>
                            </Link>
                            <Link href="#" style={{ padding: '10px', borderRadius: '10px' }} className="link">
                                <div className="d-flex">
                                    <LogoutSharpIcon style={{ marginRight: '10px', color: '#272343' }} />
                                    <p style={{ color: "#272343", fontWeight: "normal", margin: '0px' }}>Đăng xuất</p>
                                </div>
                            </Link>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

    )
}
export default AdminPage;
