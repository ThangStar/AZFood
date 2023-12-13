import { useEffect, useState } from "react";
import formatMoney from "../utils/formatMoney";

const ReportProduct = ({ originalList }: { originalList: Array<any> }) => {

    const [productList, setProductList] = useState([])
    const [sumQuantity, setSumQuantity] = useState(0)

    useEffect(() => {
        if (originalList && originalList.length > 0) {
            const productMap = new Map()
            originalList.forEach((item) => {
                const { poductName, totalQuantity } = item;

                if (!productMap.has(poductName)) {
                    productMap.set(poductName, {
                        poductName,
                        totalQuantity: 0,
                    });
                }

                const product = productMap.get(poductName);
                product.totalQuantity += parseInt(totalQuantity, 10);
            })
            // Chuyển đối tượng Map thành mảng listProduct
            const listProduct: any = Array.from(productMap.values());
            setProductList(listProduct)

            let totalQuantitySum = 0;

            originalList.forEach((item) => {
                const { totalQuantity } = item;
                totalQuantitySum += parseInt(totalQuantity, 10);
            });
            setSumQuantity(totalQuantitySum)
        }
    }, [originalList])
    return (
        <div className="card card-body border-0 p-0 m-3">
            {productList && productList.length > 0 ?
                <table className="table table-striped projects">
                    <thead >
                        <tr >
                            <th>
                                Tên sản phẩm
                            </th>
                            <th className="text-right">
                                Số lượng
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {productList.map((item: any) => (
                            <tr key={item && item.poductName ? item.poductName : null}>
                                <td className="project_progress">
                                    {item.poductName}
                                </td>
                                <td className="project_progress text-right">
                                    {item && item.totalQuantity ? formatMoney(item.totalQuantity) : ""}
                                </td>
                            </tr>
                        ))}
                        <tr>
                            <th colSpan={1} className="project_progress">
                                Tổng cộng :
                            </th>
                            <td className="project_progress text-right fw-bold">
                                {formatMoney(sumQuantity)}
                            </td>
                        </tr>
                    </tbody>
                </table>
                :
                <div>Không có dữ liệu</div>
            }
        </div>
    )
}

export default ReportProduct
