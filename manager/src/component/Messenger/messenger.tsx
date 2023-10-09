'use client'
import { useState } from "react"

const Messenger = () => {
    const [showChat, setShowChat] = useState(false)
    const [message, setMessage] = useState('')
    const [showBtnSend, setShowBtnSend] = useState(false)
    const listMessages: any[] = data
    const onToggleChat = () => {
        setShowChat(!showChat)
    }


    const onChangeMessage = (text: any) => {
        setMessage(text)
        if (text.trim().length > 0) {
            setShowBtnSend(true)
        } else {
            setShowBtnSend(false)
        }
    }

    return (
        <div className="position-fixed bottom-0 end-0 m-4 " style={{ zIndex: 3000 }}>
            {showChat ?
                <button className="btn btn-lg btn-primary rounded-pill shadow-lg" onClick={() => onToggleChat()}>
                    Tin nhắn
                </button>
                :
                <div className="shadow bg-white d-flex flex-column" style={{ width: 350, height: 500 }}>
                    <div className="px-3 py-2 d-flex justify-content-between align-items-center border-bottom">
                        <div className="h4">Tin nhắn ...</div>
                        <button className="btn" onClick={() => onToggleChat()}>
                            <i className="">ẩn</i>
                        </button>
                    </div>

                    <div className="px-3 pt-2 pb-1 flex-grow-1" style={{ overflowY: "scroll" }}>
                        {listMessages && listMessages.length > 0 &&
                            data.map(message => (<ItemMessage item={message} />))
                        }
                    </div>

                    <div className="border-top">
                        <form className="d-flex p-2 align-items-center">
                            <div className="flex-grow-1">
                                <input type="text" className="form-control" placeholder="Nhập tin nhắn..." value={message} onChange={(e) => onChangeMessage(e.target.value)} />
                            </div>
                            <div className="flex-grow-0 ms-2">
                                <button type="submit" className={`btn btn-primary ${!showBtnSend && 'disabled'}`}>Gửi</button>
                            </div>
                        </form>
                    </div>
                </div>
            }

        </div>
    )
}

const ItemMessage = (props: any) => {
    const { item } = props
    const user = 6
    const isSender = item?.sendBy === user
    return (
        <div className="row justify-content-between pb-2">
            {!isSender ?
                <>
                    <div className="col-9" title={item?.dateTime}>
                        <div style={{ fontSize: 12 }}>Người gửi {item?.sendBy}</div>
                        <div className="px-2 py-1 bg-secondary rounded-3 float-start">
                            {item?.message}
                        </div>
                    </div>
                    <div className="col-3"></div>
                </>
                :
                <>
                    <div className="col-3"></div>
                    <div className="col-9" title={item?.dateTime}>
                        <div className="px-2 py-1 bg-primary text-white rounded-3 float-end">
                            {item?.message}
                        </div>
                    </div>
                </>
            }
        </div>
    )
}

export default Messenger

const data = [
    { id: 1, type: 1, message: 'Tin nhắn 1', sendBy: 1, dateTime: '2023-02-10T12:30:00' },
    { id: 2, type: 1, message: 'Tin nhắn 2', sendBy: 2, dateTime: '2023-02-10T12:30:00' },
    { id: 3, type: 1, message: 'Tin nhắn 3', sendBy: 3, dateTime: '2023-02-10T12:30:00' },
    { id: 4, type: 1, message: 'Tin nhắn 4', sendBy: 4, dateTime: '2023-02-10T12:30:00' },
    { id: 5, type: 1, message: 'Tin nhắn 5', sendBy: 5, dateTime: '2023-02-10T12:30:00' },
    { id: 6, type: 1, message: 'Tin nhắn 6', sendBy: 6, dateTime: '2023-02-10T12:30:00' },
    { id: 7, type: 1, message: 'Tin nhắn 7', sendBy: 7, dateTime: '2023-02-10T12:30:00' },
    { id: 8, type: 1, message: 'Tin nhắn 8', sendBy: 8, dateTime: '2023-02-10T12:30:00' },
    { id: 9, type: 1, message: 'Tin nhắn 9', sendBy: 9, dateTime: '2023-02-10T12:30:00' },
]; 