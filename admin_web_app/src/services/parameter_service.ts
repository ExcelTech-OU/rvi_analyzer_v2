import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'

export interface ParameterListResponse {
    status: string
    statusDescription: string
    parameters: List<Parameter>
}

export interface Parameter {
    name: string,
    createdBy: string,
    createdDateTime: string
}

export interface ParameterGetResponse {
    status: string,
    statusDescription: string,
    name: string
}

export const parameterApi = createApi({
    reducerPath: 'parameterApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://rvi.v2.exceltch.com/rvi-analyzer-api/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['parameterList'],
    endpoints: (build) => ({
        getParameters: build.query<ParameterListResponse, {}>({
            query: () => `rvi/analyzer/v1/parameters`,
            providesTags: [{ type: 'parameterList', id: "getParameters" }]

        }),
        addParameter: build.mutation<ParameterGetResponse, {}>({
            query(body) {
                return {
                    url: `register/parameter`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'parameterList', id: "getParameters" }]
        }),
    }),
})

export const {
    useAddParameterMutation,
    useGetParametersQuery,
} = parameterApi