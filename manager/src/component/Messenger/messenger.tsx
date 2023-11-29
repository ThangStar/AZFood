// component\Messenger\messenger.tsx
'use client'
import { useSocket } from "@/socket/io.init"
import { useEffect, useRef, useState } from "react"

const Messenger = () => {
    const [showChat, setShowChat] = useState(false)
    const [userID, setUserID] = useState()
    const [textMessage, setTextMessage] = useState('')
    const [typeMessage, setTypeMessage] = useState(1)
    const [listMessages, setListMessages] = useState([])
    const [showBtnSend, setShowBtnSend] = useState(false)
    const socket = useSocket();
    const messagesRef = useRef<HTMLDivElement>(null);

    // useEffect(() => {
    //     const userObject = localStorage.getItem('user');
    //     console.log('testMess', userObject);

    //     if (typeof userObject === 'object') {
    //         localStorage.setItem('user', JSON.stringify(userObject));
    //         // setUserID(JSON.parse(userObject.toString()).userID);
    //     } else {
    //         console.error('Dữ liệu không phải là một đối tượng JSON.');
    //     }
    // }, []);
    useEffect(() => {
        const userLocal = localStorage.getItem('user');
        if (userLocal) {
            setUserID(JSON.parse(userLocal).userID);
        }
    }, []);

    useEffect(() => {
        if (socket) {
            socket.emit('client-msg-init-group');
            socket.on('sever-msg-init-group', (data) => {
                if (data !== 'error') {
                    setListMessages(data);
                }
            })
        }
    }, [socket]);

    useEffect(() => {
        ScrollToBottom()
    }, [listMessages]);

    const onToggleChat = () => {
        setShowChat(!showChat)
    }

    const ScrollToBottom = () => {
        if (messagesRef.current) {
            messagesRef.current.scrollTop = messagesRef.current.scrollHeight;
        }
    }

    const onChangeMessage = (text: any) => {
        setTextMessage(text)
        if (text.trim().length > 0) {
            setShowBtnSend(true)
        } else {
            setShowBtnSend(false)
        }
    }

    const createMessage = () => {
        console.log(userID)
        const data = {
            type: typeMessage,
            message: textMessage,
            raw: null,
            imageUrl: null,
            sendBy: userID,
        }
        socket?.emit('client-msg-group', data)
        setTextMessage('')
    }

    return (
        <div className="position-fixed bottom-0 end-0 m-4 " style={{ zIndex: 3000 }}>
            {!showChat ?
                <button className="btn btn-lg btn-primary rounded-pill shadow-lg" onClick={() => onToggleChat()}>
                    <i className="fas fa-comment-dots"></i>
                </button>
                :
                <div className="shadow bg-white d-flex flex-column" style={{ width: 400, maxHeight: 600 }}>
                    <div className="px-3 py-2 d-flex justify-content-between align-items-center border-bottom">
                        <div className="h4">Tin nhắn ...</div>
                        <button className="btn" onClick={() => onToggleChat()}>
                            <i className="fas fa-times"></i>
                        </button>
                    </div>

                    <div ref={messagesRef} className="px-3 pt-2 pb-1 flex-grow-1" style={{ overflow: "auto" }}>
                        {listMessages && listMessages.length > 0 ?
                            listMessages.map((message, i) => (<ItemMessage item={message} key={i} userID={userID} />))
                            :
                            <div>Trống</div>
                        }
                    </div>

                    <div className="border-top d-flex p-2 align-items-center">
                        <div className="flex-grow-1">
                            <input type="text" className="form-control" placeholder="Nhập tin nhắn..." value={textMessage} onChange={(e) => onChangeMessage(e.target.value)} />
                        </div>
                        <div className="flex-grow-0 ms-2">
                            <button className={`btn btn-primary ${!showBtnSend && 'disabled'}`} onClick={() => createMessage()}>
                                <i className="fas fa-paper-plane"></i>
                            </button>
                        </div>
                    </div>
                </div>
            }
        </div>
    )
}

const ItemMessage = (props: any) => {
    const { item, userID } = props
    const isSender = item?.sendBy === userID
    return (
        <div className="row justify-content-between pb-2">
            {!isSender ?
                <>
                    <div className="col-9" title={item?.dateTime}>
                        <div style={{ fontSize: 12 }}>{item?.profile.name}</div>
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