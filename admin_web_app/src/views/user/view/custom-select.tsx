import React, { useState } from "react";
import Select from "react-select";
import { useFormik } from "formik";
export default ({ onChange, options, value, className, name, id, onBlur }) => {
  const defaultValue = (options: any[], values: any) => {
    return options ? options.find((option) => option.value === value) : "";
  };

  const [blur, setHandleBlur] = useState(false);
  const [focus, setHandleFocus] = useState(false);

  const handleBlur = () => {
    setHandleFocus(false);
    setHandleBlur(true);
    console.log("on blur");
  };

  const handleFocus = () => {
    setHandleBlur(false);
    setHandleFocus(true);
    console.log("on focus");
  };

  const customStyles = {
    control: (styles) => ({
      ...styles,
      // backgroundColor: "#1769aa",
      paddingTop: 10,
      paddingBottom: 10,
      borderRadius: "8px",
      borderColor: "#9e9e9e",
    }),
  };
  return (
    <div className={className}>
      <Select
        options={options}
        name={name}
        id={id}
        isClearable={true}
        value={defaultValue(options, value)}
        onChange={(value) => onChange(value)}
        // onFocus={handleFocus}
        // onBlur={handleBlur}
        styles={customStyles}
      />
    </div>
  );
};
