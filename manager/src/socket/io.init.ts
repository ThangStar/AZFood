// hooks/useSocket.ts
import { useEffect, useState } from 'react';
import { io, Socket } from 'socket.io-client';

const SOCKET_SERVER_URL = 'http://localhost:3434';

export const useSocket = () => {
  const [socket, setSocket] = useState<Socket | null>(null);

  useEffect(() => {
    const socketIoConnection = io(SOCKET_SERVER_URL);
    setSocket(socketIoConnection);

    // Cleanup the connection when the component is unmounted
    return () => {
      socketIoConnection.disconnect();
    };
  }, []);

  return socket;
};
