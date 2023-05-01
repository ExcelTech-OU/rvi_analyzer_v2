import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'

export interface LoginResponse {
    state: string
    stateDescription: string
    user: SimpleUser
    jwt: string
}

export interface SimpleUser {
    userName: string
    type: string
    status: string
    createdBy: string
    createdDateTime: string
}

export const loginApi = createApi({
    reducerPath: 'loginApi',
    baseQuery: fetchBaseQuery({ baseUrl: 'http://rvi.analyzer.admin.exceltch.com/rvi-analyzer-api/' }),
    tagTypes: ['loginRequest'],
    endpoints: (build) => ({
        login: build.mutation<LoginResponse, {}>({
            query(body) {
                return {
                    url: `login/admin`,
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