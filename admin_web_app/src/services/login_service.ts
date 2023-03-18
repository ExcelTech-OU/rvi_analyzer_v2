import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'

export interface LoginResponse {
    state: string
    stateDescription: string
    simpleUser: SimpleUser
    jwt: string
}

export interface SimpleUser {
    username: string
    name: string
    lastLogin: string
}

export const loginApi = createApi({
    reducerPath: 'loginApi',
    baseQuery: fetchBaseQuery({ baseUrl: 'http://18.136.146.172/achilles-api/' }),
    tagTypes: ['loginRequest'],
    endpoints: (build) => ({
        login: build.mutation<LoginResponse, {}>({
            query(body) {
                return {
                    url: `user/login`,
                    method: 'POST',
                    body,
                }
            },
        }),
    }),
})

export const {
    useLoginMutation,
} = loginApi