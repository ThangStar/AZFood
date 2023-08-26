import { configureStore, ThunkAction, Action } from '@reduxjs/toolkit';
import menuItemReducer from './menuItem-reducer/menuItemSlice';
import authenticationReducer from './login-reducer/loginSlice';

export const store = configureStore({
  reducer: {
    menuItemState: menuItemReducer,
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