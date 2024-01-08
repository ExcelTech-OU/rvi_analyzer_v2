import { configureStore } from '@reduxjs/toolkit'
import { loginApi } from '../services/login_service'
import { sessionApi } from '../services/sessions_service'

export const store = configureStore({
    reducer: {
        [loginApi.reducerPath]: loginApi.reducer,
        [sessionApi.reducerPath]: sessionApi.reducer,
    },
    middleware: (getDefaultMiddleware) =>
        getDefaultMiddleware().concat(loginApi.middleware)
            .concat(sessionApi.middleware)
})

// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch