import { configureStore, ThunkAction, Action } from '@reduxjs/toolkit';
import menuItemReducer from './menuItem-reducer/menuItemSlice';
import tableReducer from './table-reducer/tableSlice';
import orderReducer from './order-reducer/orderSlice';
import userReducer from './user-reducer/userSlice';
import authenticationReducer from './login-reducer/loginSlice';

export const store = configureStore({
  reducer: {
    menuItemState: menuItemReducer,
    tableState: tableReducer,
    orderState: orderReducer,
    userState: userReducer,
    authenticationState:authenticationReducer
  },
});

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;