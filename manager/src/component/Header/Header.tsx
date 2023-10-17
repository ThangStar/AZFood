import Link from "next/link";

const Header = () => {
    return (
        <div className=" navbar navbar-expand" style={{backgroundColor: '#BAE8E8'}}>
            <div className="d-flex" style={{ alignItems: 'center', justifyContent: 'center' }}>
            <img src="img\logo\chicken.png" alt="" style={{height: '40px'}}/>
                <span className="brand-text fs-4 col-sm-8 fw-bolder" style={{ color: '#272343' }}>AZFOOD</span>
            </div>

            <ul className="navbar-nav ml-auto">
                <li className="nav-item dropdown">
                    <a className="nav-link" data-toggle="dropdown" href="#">
                        <i className="far fa-bell"></i>
                        <span className="badge badge-warning navbar-badge">15</span>
                    </a>
                    <div className="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                        <span className="dropdown-item dropdown-header">15 Notifications</span>
                        <div className="dropdown-divider"></div>
                        <a href="#" className="dropdown-item">
                            <i className="fas fa-envelope mr-2"></i> 4 new messages
                            <span className="float-right text-muted text-sm">3 mins</span>
                        </a>
                        <div className="dropdown-divider"></div>
                        <a href="#" className="dropdown-item">
                            <i className="fas fa-users mr-2"></i> 8 friend requests
                            <span className="float-right text-muted text-sm">12 hours</span>
                        </a>
                        <div className="dropdown-divider"></div>
                        <a href="#" className="dropdown-item">
                            <i className="fas fa-file mr-2"></i> 3 new reports
                            <span className="float-right text-muted text-sm">2 days</span>
                        </a>
                        <div className="dropdown-divider"></div>
                        <a href="#" className="dropdown-item dropdown-footer">See All Notifications</a>
                    </div>
                </li>
                <li className="nav-item">
                    <img src="img\about-us-1.jpg" alt="" style={{height: '40px',width: '40px', borderRadius: '20px', margin:'0 15px'}} />
                </li>
            </ul>
        </div>

    )
}
export default Header;