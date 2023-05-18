import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'
import { GeneralResponse } from './device_service'

export type QuestionListResponseAdmin = {
    questions: List<QuestionListResponse>
}

export type QuestionListResponse = {
    question: Question
    answers: []
}

export interface Question {
    id: string
    formFieldType: string
    question: string
    enabled: boolean
    createdDate: string
    lastUpdatedDate: string
}

export const questionsApi = createApi({
    reducerPath: 'questionsApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://54.251.199.35/rvi-analyzer-api/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['questionsApi'],
    endpoints: (build) => ({
        getQuestions: build.query<QuestionListResponseAdmin, {}>({
            query: () => `resource/questions/admin`,
            providesTags: [{ type: 'questionsApi', id: "getQuestions" }]

        }),
        updateQuestion: build.mutation<GeneralResponse, {}>({
            query(body) {
                return {
                    url: `resource/questions/admin/update`,
                    method: 'POST',
                    body,
                }
            },
            invalidatesTags: [{ type: 'questionsApi', id: "getQuestions" }]
        }),
    }),
})

export const {
    useGetQuestionsQuery,
    useUpdateQuestionMutation
} = questionsApi