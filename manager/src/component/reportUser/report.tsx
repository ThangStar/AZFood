import { useEffect, useState } from "react";
import formatMoney from "../utils/formatMoney";

const ReportUser = ({ originalList }: { originalList: Array<any> }) => {

    const [userList, setUserList] = useState([])
    const [sumMoney, setSumMoney] = useState(0)

    useEffect(() => {
        if (originalList && originalList.length > 0) {
            const userMap = new Map()
            originalList.forEach((item) => {
                const { userID, userName, totalAmount } = item;

                if (!userMap.has(userID)) {
                    userMap.set(userID, {
                        userID,
                        userName,
                        totalAmount: 0,
                    });
                }

                const user = userMap.get(userID)
                user.totalAmount += totalAmount
            })
            const listUser: any = Array.from(userMap.values())
            setUserList(listUser)

            const totalAmountSum = originalList.reduce((accumulator, currentItem) => {
                return accumulator + currentItem.totalAmount
            }, 0)
            setSumMoney(totalAmountSum)
        }
    }, [originalList])
    return (
        <div className="card card-body border-0 p-0 m-3">
            {userList && userList.length > 0 ?
                <table className="table table-striped projects">
                    <thead >
                        <tr >
                            <th>
                                Mã NV
                            </th>
                            <th>
                                Tên nhân viên
                            </th>
                            <th className="text-right">
                                Tổng số tiền
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {userList.map((item: any) => (
                            <tr key={item && item.userID ? item.userID : null}>
                                <td className="project_progress">
                                    {item.userID}
                                </td>
                                <td className="project_progress">
                                    {item && item.userName ? item.userName : ""}
                                </td>
                                <td className="project_progress text-right">
                                    {item && item.totalAmount ? formatMoney(item.totalAmount) + ' ₫' : ""}
                                </td>
                            </tr>
                        ))}
                        <tr>
                            <th colSpan={2} className="project_progress">
                                Tổng cộng :
                            </th>
                            <td className="project_progress text-right fw-bold">
                                {formatMoney(sumMoney) + ' ₫'}
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

export default ReportUser
