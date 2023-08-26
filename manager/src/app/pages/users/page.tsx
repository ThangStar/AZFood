import Image from 'next/image'

export default function User() {
    return (
        <>
        <div className="main-header card" >
            <div className="card-header">
                <div className="container-fluid">
                    <div className="row mb-2">
                        <div className="col-sm-6">
                            <h1>Danh sách Nhân viên</h1>
                        </div>
                        <div className="col-sm-6">
                            <ol className="breadcrumb float-sm-right">
                                <li className="breadcrumb-item"><a href="#">Home</a></li>
                                <li className="breadcrumb-item active">Danh sách nhân viên</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <div className="content">

                <div className="card">
                    <div className="card-header">
                        <button className="btn btn-success">Thêm nhân viên</button>

                        <div className="card-tools">
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
                                        actions
                                    </th>

                                </tr>
                            </thead>
                            <tbody>
                                {/* {menuItems && menuItems.length > 0 ? menuItems.map((item: any, i: number) => (
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
                                        <td className="project_progress">
                                            {item && item.price ? item.price : null}
                                        </td>
                                        <td className="project_progress">
                                            {item && item.category_name ? item.category_name : ""}
                                        </td>
                                        <td className="project_progress">
                                            {item && item.dvt_name ? item.dvt_name : null}
                                        </td>
                                        <td className="project_progress">
                                            {item && item.status === 1 ? "Còn hàng" : item.status == 2 ? "Hết hàng" :  item.quantity == 0 ? "Hết hàng" : item.quantity}
                                        </td>
                                        <td className="project-actions text-right">
                                            <div className="d-flex justify-content-between " >
                                                <a className="btn btn-primary btn-sm" href="#">
                                                    <i className="fas fa-folder">
                                                    </i>
                                                    View
                                                </a>
                                                <button className="btn btn-success btn-sm pd-5" >
                                                    <i className="fas fa-pencil-alt"></i>
                                                    <Link href={`create-product?id=${item && item.id ? item.id : null}`}>
                                                        Edit
                                                    </Link>
                                                </button>
                                                <button className="btn btn-danger btn-sm" >
                                                    <i className="fas fa-trash"></i> Delete
                                                </button>
                                            </div>

                                        </td>
                                    </tr>
                                )) : ""} */}


                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
            </div>
            </>
    )
}
