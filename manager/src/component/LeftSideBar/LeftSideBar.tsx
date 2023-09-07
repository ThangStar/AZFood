import Link from "next/link";
const AdminPage = () => {
    return (
        <div className="main-sidebar sidebar-dark-primary elevation-4">

            <a href="index3.html" className="brand-link">
                <img src="/img/AdminLTELogo.png" alt="AdminLTE Logo" className="brand-image img-circle "
                    style={{ opacity: .8 }} />
                <span className="brand-text font-weight-light">AdminLTE 3</span>
            </a>
            <div className="sidebar">
                <div className="user-panel mt-3 pb-3 mb-3 d-flex">
                    <div className="image">
                        <img src="/img/user2-160x160.jpg" className="img-circle elevation-2" alt="User Image" />
                    </div>
                    <div className="info">
                        <a href="#" className="d-block">Alexander Pierce</a>
                    </div>
                </div>
                <div className="form-inline">
                    <div className="input-group" data-widget="sidebar-search">
                        <input className="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search" />
                        <div className="input-group-append">
                            <button className="btn btn-sidebar">
                                <i className="fas fa-search fa-fw"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <nav className="mt-2">
                    <ul className="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                        <li className="nav-item" >
                            <div className="" >
                                <i className="far fa-circle nav-icon "></i>
                                <Link href="/pages/table" style={{ color: "black", fontWeight: "bold" }}>Danh Sách Bàn</Link>
                            </div>
                        </li>
                        <li className="nav-item ">
                            <div className="">
                                <i className="far fa-circle nav-icon "></i>
                                <Link href="/pages/users" style={{ color: "black", fontWeight: "bold" }}>Danh Sách Nhân Viên</Link>
                            </div>
                        </li>
                        <li className="nav-item">
                            <div className=" ">
                                <i className="far fa-circle nav-icon "></i>
                                <Link href="/pages/menuItem" style={{ color: "black", fontWeight: "bold" }}>Danh Sách Món Ăn</Link>
                            </div>
                        </li>
                        <li className="nav-item ">
                            <div className="">
                                <i className="far fa-circle nav-icon "></i>
                                <Link href="/pages/kho" style={{ color: "black", fontWeight: "bold" }}>Phiếu nhập hàng</Link>
                            </div>
                        </li>
                        <li className="nav-item ">
                            <div className="">
                                <i className="far fa-circle nav-icon "></i>
                                <Link href="/pages/invoice" style={{ color: "black", fontWeight: "bold" }}>Danh sách hóa đơn</Link>
                            </div>
                        </li>
                    </ul>
                </nav>

            </div>
        </div>

    )
}
export default AdminPage;
